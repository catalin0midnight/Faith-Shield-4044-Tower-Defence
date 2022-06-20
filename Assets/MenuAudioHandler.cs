using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TDTK;

public class MenuAudioHandler : MonoBehaviour
{

    public Slider sliderMusicVolume;
    public Slider sliderSFXVolume;
    // Start is called before the first frame update
    void Start()
    {
        if (sliderMusicVolume != null)
        {
            sliderMusicVolume.value = AudioManager.GetVolumeSFX();
            sliderMusicVolume.onValueChanged.AddListener(delegate { OnSFXVolumeChanged(); });
        }
        if (sliderSFXVolume != null)
        {
            sliderSFXVolume.value = AudioManager.GetVolumeUI();
            sliderSFXVolume.onValueChanged.AddListener(delegate { OnUIVolumeChanged(); });
        }
    }

    public void OnSFXVolumeChanged()
    {
        AudioManager.SetVolumeSFX(sliderMusicVolume.value);
    }
    public void OnUIVolumeChanged()
    {
        AudioManager.SetVolumeUI(sliderSFXVolume.value);
    }
}
