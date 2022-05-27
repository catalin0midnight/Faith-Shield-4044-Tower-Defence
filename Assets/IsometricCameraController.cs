using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IsometricCameraController : MonoBehaviour
{
    [SerializeField]
    private float zoomVelocity = 1f;
    [SerializeField]
    private float minCamSize = 10f;
    [SerializeField]
    private float maxCamSize = 25f;

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
        zoomVelocity -= Input.GetAxis("Mouse ScrollWheel") * 2f;
        zoomVelocity = Mathf.Lerp(zoomVelocity, 0f, Time.deltaTime * 5f);
    }

    private void LateUpdate()
    {
        CalculateZoom();
    }

}