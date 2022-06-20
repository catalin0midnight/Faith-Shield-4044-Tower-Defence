using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DarkTonic.MasterAudio;

public class PlaylistSwitcher : MonoBehaviour
{
    public void SwitchPlaylist()
    {
        MasterAudio.StartPlaylist("MenuMusic");

    }
}
