using UnityEngine;

public class HarbingerBayDoors : MonoBehaviour
{
    public Transform[] MissilePodsLeft, MissilePodsRight;
    public Transform ShieldGenLeft, ShieldGenRight, ShieldGenRear;
    public Transform DroneBay;
    public bool DroneBayOpen;
    public bool ShieldGenLeftOpen, ShieldGenRightOpen, ShieldGenRearOpen;
    public bool MissilePodsLeftOpen, MissilePodsRightOpen;
    public float DroneBayDegreesDelta;
    public float ShieldGenDegreesDelta;
    public float MissilePodsDegreesDelta;
    public Vector3 ShieldGenLeftFrom, ShieldGenLeftTo;
    public Vector3 ShieldGenRightFrom, ShieldGenRightTo;
    public Vector3 ShieldGenRearFrom, ShieldGenRearTo;
    public Vector3 MissilePodsLeftFrom, MissilePodsLeftTo;
    public Vector3 MissilePodsRightFrom, MissilePodsRightTo;
    public Vector3 DroneBayFrom, DroneBayTo;

    // Update is called once per frame
    void Update()
    {
        DroneBay.localRotation = Quaternion.RotateTowards(DroneBay.localRotation,
            !DroneBayOpen ? Quaternion.Euler(DroneBayFrom) : Quaternion.Euler(DroneBayTo), DroneBayDegreesDelta);
        ShieldGenLeft.localRotation = Quaternion.RotateTowards(ShieldGenLeft.localRotation,
            !ShieldGenLeftOpen ? Quaternion.Euler(ShieldGenLeftFrom) : Quaternion.Euler(ShieldGenLeftTo),
            ShieldGenDegreesDelta);
        ShieldGenRight.localRotation = Quaternion.RotateTowards(ShieldGenRight.localRotation,
            !ShieldGenRightOpen ? Quaternion.Euler(ShieldGenRightFrom) : Quaternion.Euler(ShieldGenRightTo),
            ShieldGenDegreesDelta);
        ShieldGenRear.localRotation = Quaternion.RotateTowards(ShieldGenRear.localRotation,
            !ShieldGenRearOpen ? Quaternion.Euler(ShieldGenRearFrom) : Quaternion.Euler(ShieldGenRearTo),
            ShieldGenDegreesDelta);
        for (var i = 0; i < MissilePodsLeft.Length; i++)
        {
            MissilePodsLeft[i].localRotation = Quaternion.RotateTowards(MissilePodsLeft[i].localRotation,
                !MissilePodsLeftOpen ? Quaternion.Euler(MissilePodsLeftFrom) : Quaternion.Euler(MissilePodsLeftTo),
                MissilePodsDegreesDelta + i * 0.1f);
            MissilePodsRight[i].localRotation = Quaternion.RotateTowards(MissilePodsRight[i].localRotation,
                !MissilePodsRightOpen ? Quaternion.Euler(MissilePodsRightFrom) : Quaternion.Euler(MissilePodsRightTo),
                MissilePodsDegreesDelta + i * 0.1f);
        }
    }
}