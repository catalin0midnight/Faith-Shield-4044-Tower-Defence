using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class IsometricCameraController : MonoBehaviour
{
    [SerializeField]
    private float zoomVelocity = 0.5f;
    [SerializeField]
    private float zoomStep = 0.5f;
    [SerializeField]
    private float minCamSize = 20f;
    [SerializeField]
    private float maxCamSize = 25f;

    public Button zoomInButton;
    public Button zoomOutButton;

    private void LateUpdate()
    {
        CalculateZoom();
    }

    void CalculateZoom()
    {
        if (Camera.main.orthographicSize < minCamSize)
        {
            Camera.main.orthographicSize = minCamSize;
            zoomVelocity = 0f;
            return;
        }

        if (Camera.main.orthographicSize > maxCamSize)
        {
            Camera.main.orthographicSize = maxCamSize;
            zoomVelocity = 0f;
            return;
        }

        if (Camera.main.orthographicSize + zoomVelocity >= minCamSize && Camera.main.orthographicSize + zoomVelocity <= maxCamSize)
        {
            Camera.main.orthographicSize += zoomVelocity;
        }

        //zoomVelocity -= Input.GetAxis("Mouse ScrollWheel") * 2f;
        //zoomVelocity = Mathf.Lerp(zoomVelocity, 0f, Time.deltaTime * 5f);
    }

    private void OnEnable()
    {
        zoomInButton.onClick.AddListener(delegate { ZoomIn(-zoomStep); });
        zoomOutButton.onClick.AddListener(delegate { ZoomOut(zoomStep); });
    }

    public void ZoomIn(float value)
    {
        zoomVelocity -= zoomStep * 2f;
        zoomVelocity = Mathf.Lerp(zoomVelocity, 0f, Time.deltaTime * 5f);

        if(zoomVelocity <= -0.5f)
        {
            zoomVelocity = -0.5f;
        }
        
    }

    public void ZoomOut(float value)
    {
        zoomVelocity += zoomStep * 2f;
        zoomVelocity = Mathf.Lerp(zoomVelocity, 0f, Time.deltaTime * 5f);
        if (zoomVelocity >= 0.5f)
        {
            zoomVelocity = 0.5f;
        }
    }
}