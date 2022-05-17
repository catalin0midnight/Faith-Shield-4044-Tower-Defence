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

    private Vector3 dragOrigin;

    [SerializeField] private Vector2 xBoundWorld;
    [SerializeField] private Vector2 yBoundWorld;
    [SerializeField] public bool HorizentalDrag = true;
    [SerializeField] public bool VerticalDrag = true;
    [SerializeField] public float speedFactor = 10;

    private float leftLimit;
    private float rightLimit;
    private float topLimit;
    private float downLimit;

    public bool allowDrag = true;

    private void Start()
    {
        CalculateLimitsBasedOnAspectRatio();
    }

    public void UpdateBounds(Vector2 xBoundNew, Vector2 yBoundNew)
    {
        xBoundWorld = xBoundNew;
        yBoundWorld = yBoundNew;
        CalculateLimitsBasedOnAspectRatio();
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

        if (
            Camera.main.orthographicSize + zoomVelocity >= minCamSize &&
            Camera.main.orthographicSize + zoomVelocity <= maxCamSize
        )
        {
            Camera.main.orthographicSize += zoomVelocity;
        }

        zoomVelocity -= Input.GetAxis("Mouse ScrollWheel") * 2f;
        zoomVelocity = Mathf.Lerp(zoomVelocity, 0f, Time.deltaTime * 5f);
    }

    private void CalculateLimitsBasedOnAspectRatio()
    {
        leftLimit = xBoundWorld.x - Camera.main.ViewportToWorldPoint(new Vector3(0, 0, 0)).x;
        rightLimit = xBoundWorld.y - Camera.main.ViewportToWorldPoint(new Vector3(1, 0, 0)).x;
        downLimit = yBoundWorld.x - Camera.main.ViewportToWorldPoint(new Vector3(0, 0, 0)).y;
        topLimit = yBoundWorld.y - Camera.main.ViewportToWorldPoint(new Vector3(0, 1, 0)).y;
    }

    Vector3 lastPosView; // we use viewport because we don't want devices pixel density affect our swipe speed
    private void LateUpdate()
    {
        CalculateZoom();

        if (allowDrag)
        {
            if (Input.GetMouseButtonDown(0))
            {
                lastPosView = Camera.main.ScreenToViewportPoint(Input.mousePosition);
            }
            else if (Input.GetMouseButton(0))
            {
                var newPosView = Camera.main.ScreenToViewportPoint(Input.mousePosition);
                var cameraMovment = (lastPosView - newPosView) * speedFactor;
                lastPosView = newPosView;

                cameraMovment = Limit2Bound(cameraMovment);

                if (HorizentalDrag)
                    Camera.main.transform.localPosition = new Vector3(cameraMovment.x, 0, 0);
                if (VerticalDrag)
                    Camera.main.transform.localPosition = new Vector3(0, cameraMovment.y, 0);
            }
        }
    }

    private Vector3 Limit2Bound(Vector3 distanceView)
    {
        if (distanceView.x < 0) // Check left limit
        {
            if (Camera.main.transform.localPosition.x + distanceView.x < leftLimit)
            {
                distanceView.x = leftLimit - Camera.main.transform.localPosition.x;
            }
        }
        else // Check right limit
        {
            if (Camera.main.transform.localPosition.x + distanceView.x > rightLimit)
            {
                distanceView.x = rightLimit - Camera.main.transform.localPosition.x;
            }
        }

        if (distanceView.y < 0) // Check down limit
        {
            if (Camera.main.transform.localPosition.y + distanceView.y < downLimit)
            {
                distanceView.y = downLimit - Camera.main.transform.localPosition.y;
            }
        }
        else // Check top limit
        {
            if (Camera.main.transform.localPosition.y + distanceView.y > topLimit)
            {
                distanceView.y = topLimit - Camera.main.transform.localPosition.y;
            }
        }

        return distanceView;
    }

}