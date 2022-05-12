using System;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class HarbingerFXEngine : MonoBehaviour
{
    private enum FXEngine
    {
        Main,
        MainReverse,
        LeftFrontTop,
        LeftFrontBottom,
        LeftFrontSide,
        RightFrontTop,
        RightFrontBottom,
        RightFrontSide,
        LeftRearTop,
        LeftRearBottom,
        LeftRearSide,
        RightRearTop,
        RightRearBottom,
        RightRearSide
    }

    public Color MainEngineColor;
    public Vector3 Velocity;
    public Vector3 Angular;
    private Vector3 _lastVelocity, _lastAngular;
    private List<List<ParticleSystem>> fxDrives = new List<List<ParticleSystem>>();
    public List<MeshRenderer> fxMainEngineRenderers = new List<MeshRenderer>();
    public List<MeshRenderer> fxMainEngineReverseRenderers = new List<MeshRenderer>();

    private void Awake()
    {
        foreach (FXEngine fxEngine in Enum.GetValues(typeof(FXEngine)))
        {
            var driveList = new List<ParticleSystem>();
            GetFXDrivesInChild(transform, ref driveList, "FXEngine" + fxEngine);
            fxDrives.Add(driveList);
        }
        foreach (var meshRenderer in fxMainEngineRenderers)
            meshRenderer.materials[2].SetColor("_EmissionColor", Color.black);
        foreach (var meshRenderer in fxMainEngineReverseRenderers)
            meshRenderer.materials[2].SetColor("_EmissionColor", Color.black);
    }

    private void GetFXDrivesInChild(Transform parent, ref List<ParticleSystem> driveList, string _tag)
    {
        for (var i = 0; i < parent.childCount; i++)
        {
            var child = parent.GetChild(i);
            if (child.CompareTag(_tag))
            {
                var pSys = child.GetComponent<ParticleSystem>();
                if (pSys != null)
                {
                    pSys.Stop(true, ParticleSystemStopBehavior.StopEmittingAndClear);
                    driveList.Add(pSys);
                }
            }
            if (child.childCount > 0)
                GetFXDrivesInChild(child, ref driveList, _tag);
        }
    }

    private void SetFXEngine(FXEngine engine, float value)
    {
        var value01 = Mathf.Clamp01(value);
        var id = (int) engine;
        for (var i = 0; i < fxDrives[id].Count; i++)
        {
            var pSys = fxDrives[id][i];
            if (Math.Abs(value01) < Mathf.Epsilon && pSys.isPlaying)
                pSys.Stop(true);
            else if (Math.Abs(value01) > Mathf.Epsilon)
            {
                if (fxDrives[id][i].isStopped)
                    pSys.Play(true);
                var pSysMain = pSys.main;
                pSysMain.startColor = Color.Lerp(Color.black, Color.white, value01);
                pSysMain.startSizeX = Mathf.Lerp(0.5f, 1.0f, value01);
                pSysMain.startSizeY = Mathf.Lerp(0.5f, 1.0f, value01);
                pSysMain.startSizeZ = Mathf.Lerp(0.15f, 1.0f, value01);
            }
        }
        if (engine == FXEngine.Main)
        {
            for (var i = 0; i < fxMainEngineRenderers.Count; i++)
            {
                var meshRenderer = fxMainEngineRenderers[i];
                meshRenderer.materials[2].SetColor("_EmissionColor",
                    Color.Lerp(Color.black, MainEngineColor * MainEngineColor.a * 10, value));
            }
        }
        else if (engine == FXEngine.MainReverse)
        {
            for (var i = 0; i < fxMainEngineReverseRenderers.Count; i++)
            {
                var meshRenderer = fxMainEngineReverseRenderers[i];
                meshRenderer.materials[2].SetColor("_EmissionColor",
                    Color.Lerp(Color.black, MainEngineColor * MainEngineColor.a * 10, value));
            }
        }
    }

    // Update is called once per frame
    private void Update()
    {
        SetFXEngine(FXEngine.Main, Velocity.z);
        SetFXEngine(FXEngine.MainReverse, -Velocity.z);
        SetFXEngine(FXEngine.LeftFrontTop, -Velocity.y - Angular.x - Angular.z);

//        SetFXEngine(FXEngine.LeftFrontTop, -Angular.x);
//        SetFXEngine(FXEngine.LeftFrontTop, -Angular.z);
        SetFXEngine(FXEngine.RightFrontTop, -Velocity.y - Angular.x + Angular.z);

//        SetFXEngine(FXEngine.RightFrontTop, -Angular.x);
//        SetFXEngine(FXEngine.RightFrontTop, Angular.z);
        SetFXEngine(FXEngine.LeftRearTop, -Velocity.y + Angular.x - Angular.z);

//        SetFXEngine(FXEngine.LeftRearTop, Angular.x);
//        SetFXEngine(FXEngine.LeftRearTop, -Angular.z);
        SetFXEngine(FXEngine.RightRearTop, -Velocity.y + Angular.x + Angular.z);

//        SetFXEngine(FXEngine.RightRearTop, Angular.x);
//        SetFXEngine(FXEngine.RightRearTop, Angular.z);
        SetFXEngine(FXEngine.LeftFrontBottom, Velocity.y + Angular.x + Angular.z);

//        SetFXEngine(FXEngine.LeftFrontBottom, Angular.x);
//        SetFXEngine(FXEngine.LeftFrontBottom, Angular.z);
        SetFXEngine(FXEngine.RightFrontBottom, Velocity.y + Angular.x - Angular.z);

//        SetFXEngine(FXEngine.RightFrontBottom, Angular.x);
//        SetFXEngine(FXEngine.RightFrontBottom, -Angular.z);
        SetFXEngine(FXEngine.LeftRearBottom, Velocity.y - Angular.x + Angular.z);

//        SetFXEngine(FXEngine.LeftRearBottom, -Angular.x);
//        SetFXEngine(FXEngine.LeftRearBottom, Angular.z);
        SetFXEngine(FXEngine.RightRearBottom, Velocity.y - Angular.x - Angular.z);

//        SetFXEngine(FXEngine.RightRearBottom, -Angular.x);
//        SetFXEngine(FXEngine.RightRearBottom, -Angular.z);
        SetFXEngine(FXEngine.LeftFrontSide, Velocity.x + Angular.y);

//        SetFXEngine(FXEngine.LeftFrontSide, Angular.y);
        SetFXEngine(FXEngine.LeftRearSide, Velocity.x - Angular.y);

//        SetFXEngine(FXEngine.LeftRearSide, -Angular.y);
        SetFXEngine(FXEngine.RightFrontSide, -Velocity.x - Angular.y);

//       SetFXEngine(FXEngine.RightFrontSide, -Angular.y);
        SetFXEngine(FXEngine.RightRearSide, -Velocity.x + Angular.y);

//        SetFXEngine(FXEngine.RightRearSide, Angular.y);

       
        _lastVelocity = Velocity;
        _lastAngular = Angular;
    }
}