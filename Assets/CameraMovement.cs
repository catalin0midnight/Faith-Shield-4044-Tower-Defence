using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMovement: MonoBehaviour
{
    [SerializeField]
    private Camera cam;

    [SerializeField]
    private float zoomStep, minCamSize, maxCamSize;

    [SerializeField]
    private MeshRenderer mapRenderer;

    private Vector3 dragOrigin;

    private float mapMinX, mapMaxX, mapMinY, mapMaxY;


    private void Start()
    {
        mapMinX = mapRenderer.transform.position.x - mapRenderer.bounds.size.x / 2f;
        mapMaxX = mapRenderer.transform.position.x + mapRenderer.bounds.size.x / 2f;

        mapMinY = mapRenderer.transform.position.z - mapRenderer.bounds.size.y / 2f;
        mapMaxY = mapRenderer.transform.position.z + mapRenderer.bounds.size.y / 2f;
    }

    private void Update()
    {
        PanCamera();
    }

    private void PanCamera()
    {
        if (Input.GetButtonDown("Fire1"))
        {
            dragOrigin = cam.ScreenToWorldPoint(Input.mousePosition);
        }

        if (Input.GetButton("Fire1"))
        {
            Vector3 diff = dragOrigin - cam.ScreenToWorldPoint(Input.mousePosition);

            cam.transform.position = ClampCamera(cam.transform.position + diff);
        }

        if (Input.GetAxis("Mouse ScrollWheel") < 0f) // forward
        {
            float newSize = cam.orthographicSize + zoomStep;
            cam.orthographicSize = Mathf.Clamp(newSize, minCamSize, maxCamSize);
            cam.transform.position = ClampCamera(cam.transform.position);
        }
        else if (Input.GetAxis("Mouse ScrollWheel") > 0f) // backwards
        {
            float newSize = cam.orthographicSize - zoomStep;
            cam.orthographicSize = Mathf.Clamp(newSize, minCamSize, maxCamSize);
            cam.transform.position = ClampCamera(cam.transform.position);
        }

    }

    private Vector3 ClampCamera(Vector3 targetPosition)
    {
        float camHeight = cam.orthographicSize;
        float camWidth = cam.orthographicSize * cam.aspect;

        float minX = mapMinX + camWidth;
        float maxX = mapMaxX - camWidth;
        float minY = mapMinY + camHeight;
        float maxY = mapMaxY - camHeight;

        float newX = Mathf.Clamp(targetPosition.x, minX, maxX);
        float newY = Mathf.Clamp(targetPosition.z, minY, maxY);

        return new Vector3(newX, targetPosition.y, newY);
    }
}