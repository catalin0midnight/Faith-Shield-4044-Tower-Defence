using UnityEngine;
using System.Collections;
using System;

namespace Forge3D
{
    public class HarbingerTurret : MonoBehaviour
    {

        public Transform Target;

        public GameObject Body;
        public GameObject Mount;

        private Vector3 defaultDir;
        private Quaternion defaultRot;

        private Transform headTransform;
        private Transform barrelTransform;

        public float HeadingTrackingSpeed = 2f;
        public float ElevationTrackingSpeed = 2f;

        private Vector3 targetPos;


        private Vector3 headingVetor;

        private float curHeadingAngle = 0f;
        private float curElevationAngle = 0f;

        public Vector2 HeadingLimit;
        public Vector2 ElevationLimit;



        public bool DebugDraw = false;



        void Awake()
        {
            barrelTransform = Mount.GetComponent<Transform>();
            headTransform = Body.GetComponent<Transform>();
        }



        // Use this for initialization
        void Start()
        {
            targetPos = headTransform.transform.position + headTransform.transform.forward * 100f;
            defaultDir = Mount.transform.forward;
            defaultRot = Quaternion.FromToRotation(transform.forward, defaultDir);

        }

        // Autotrack
        public void SetNewTarget(Vector3 _targetPos)
        {
            targetPos = _targetPos;
        }

        void Update()
        {
            if (barrelTransform != null && headTransform != null)
            {
                if (Target != null)
                    targetPos = Target.position;

                /////// Heading
                headingVetor = Vector3.Normalize(ProjectVectorOnPlane(headTransform.up, targetPos - headTransform.position));
                float headingAngle = SignedVectorAngle(headTransform.forward, headingVetor, headTransform.up);
                float turretDefaultToTargetAngle = SignedVectorAngle(defaultRot * headTransform.forward, headingVetor, headTransform.up);
                float turretHeading = SignedVectorAngle(defaultRot * headTransform.forward, headTransform.forward, headTransform.up);

                float headingStep = HeadingTrackingSpeed * Time.deltaTime;

                // Heading step and correction
                // Full rotation
                if (HeadingLimit.x <= -180f && HeadingLimit.y >= 180f)
                    headingStep *= Mathf.Sign(headingAngle);
                else // Limited rotation
                    headingStep *= Mathf.Sign(turretDefaultToTargetAngle - turretHeading);

                // Hard stop on reach no overshooting
                if (Mathf.Abs(headingStep) > Mathf.Abs(headingAngle))
                    headingStep = headingAngle;

                // Heading limits
                if (curHeadingAngle + headingStep > HeadingLimit.x && curHeadingAngle + headingStep < HeadingLimit.y || HeadingLimit.x <= -180f && HeadingLimit.y >= 180f)
                {
                    curHeadingAngle += headingStep;
                    headTransform.rotation = headTransform.rotation * Quaternion.Euler(0f, headingStep, 0f);
                }

                /////// Elevation
                Vector3 elevationVector = Vector3.Normalize(ProjectVectorOnPlane(headTransform.right, targetPos - barrelTransform.position));
                float elevationAngle = SignedVectorAngle(barrelTransform.forward, elevationVector, headTransform.right);

                // Elevation step and correction
                float elevationStep = Mathf.Sign(elevationAngle) * ElevationTrackingSpeed * Time.deltaTime;
                if (Mathf.Abs(elevationStep) > Mathf.Abs(elevationAngle))
                    elevationStep = elevationAngle;

                // Elevation limits
                if (curElevationAngle + elevationStep < ElevationLimit.y && curElevationAngle + elevationStep > ElevationLimit.x)
                {
                    curElevationAngle += elevationStep;
                    barrelTransform.rotation = barrelTransform.rotation * Quaternion.Euler(elevationStep, 0f, 0f);
                }
            }

            if (DebugDraw)
                Debug.DrawLine(barrelTransform.position, barrelTransform.position + barrelTransform.forward * Vector3.Distance(barrelTransform.position, targetPos), Color.red);
        }

        //Projects a vector onto a plane. The output is not normalized.
        Vector3 ProjectVectorOnPlane(Vector3 planeNormal, Vector3 vector)
        {
            return vector - (Vector3.Dot(vector, planeNormal) * planeNormal);
        }

        float SignedVectorAngle(Vector3 referenceVector, Vector3 otherVector, Vector3 normal)
        {
            Vector3 perpVector;
            float angle;

            //Use the geometry object normal and one of the input vectors to calculate the perpendicular vector
            perpVector = Vector3.Cross(normal, referenceVector);

            //Now calculate the dot product between the perpendicular vector (perpVector) and the other input vector
            angle = Vector3.Angle(referenceVector, otherVector);
            angle *= Mathf.Sign(Vector3.Dot(perpVector, otherVector));

            return angle;
        }
    }


}