using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using Rewired;
using UnityEngine.EventSystems;

public class MenuController : MonoBehaviour
{
    // REWIRED
    [SerializeField] private int playerID = 0;
    [SerializeField] private Player player;
    //MENU UI
    [SerializeField] private GameObject optionsLayout;
    [SerializeField] private Button newGameButton;
    [SerializeField] private Button continueGameButton;
    [SerializeField] private Button optionsButton;
    [SerializeField] private Button audioButton;
    [SerializeField] private AudioSource clickSound;
    //Optins
    [SerializeField] private Slider musicSlider;
    [SerializeField] private Slider sfxSlider;
    [SerializeField] private GameObject thisMusicSlider;
    [SerializeField] private GameObject thisSFXSlider;
    [SerializeField] private Text musicText;
    [SerializeField] private Text sfxText;
    private float sliderChange;
    private float maxMusicSliderValue;
    private float minMusicSliderValue;
    private float maxSfxSliderValue;
    private float minSfxSliderValue;
    private float musicSliderRange;
    private float sfxSliderRange;
    private const float sliderStep = 100f;

    private int sceneToContinue;

    private void Awake()
    {
        player = ReInput.players.GetPlayer(playerID);

        if(musicSlider == null)
        {
            musicSlider = GetComponentInParent<Slider>();
        }
        if (sfxSlider == null)
        {
            sfxSlider = GetComponentInParent<Slider>();
        }
        thisMusicSlider = gameObject;
        thisSFXSlider = gameObject;
        maxMusicSliderValue = musicSlider.maxValue;
        minMusicSliderValue = musicSlider.minValue;
        maxSfxSliderValue = sfxSlider.maxValue;
        minSfxSliderValue = sfxSlider.minValue;
        musicSliderRange = maxMusicSliderValue - minMusicSliderValue;
        sfxSliderRange = maxSfxSliderValue - minSfxSliderValue;
    }

    private void Update()
    {
        ClosingMenuLayouts();
        TriggerOptionsMenu();   
    }

    private void TriggerOptionsMenu()
    {
        if (optionsLayout.activeSelf == true)
        {
            newGameButton.interactable = false;
            continueGameButton.interactable = false;
            optionsButton.interactable = false;
            TriggerOptions();
        }
    }

    private void TriggerOptions()
    {
        if (audioButton != null && musicSlider == EventSystem.current.currentSelectedGameObject)
        {
            musicText.color = new Color(255, 200, 0, 255);
            sfxText.color = Color.white;
            sliderChange = player.GetAxis("Horizontal") * musicSliderRange / sliderStep;
            float sliderValue = musicSlider.value;
            float tempValue = sliderValue + sliderChange;
            if (tempValue <= maxMusicSliderValue && tempValue >= minMusicSliderValue)
            {
                sliderValue = tempValue;
            }
            musicSlider.value = sliderValue;
        }

        if (audioButton != null && sfxSlider == EventSystem.current.currentSelectedGameObject)
        {
            sfxText.color = new Color(255, 200, 0, 255);
            musicText.color = Color.white;
            sliderChange = player.GetAxis("Horizontal") * sfxSliderRange / sliderStep;
            float sliderValue = sfxSlider.value;
            float tempValue = sliderValue + sliderChange;
            if (tempValue <= maxSfxSliderValue && tempValue >= minSfxSliderValue)
            {
                sliderValue = tempValue;
            }
            sfxSlider.value = sliderValue;
        }
    }

    private void ClosingMenuLayouts()
    {
        if (player.GetButtonDown("Cancel") && optionsLayout.activeSelf == true)
        {
            Debug.Log("pressed back button");
            optionsLayout.SetActive(false);
            optionsButton.Select();
            newGameButton.interactable = true;
            continueGameButton.interactable = true;
            optionsButton.interactable = true;
            clickSound.Play();
        }
    }

    public void ContinueGame()
    {
#if UNITY_SWITCH && !UNITY_EDITOR
        sceneToContinue = SaveBridge.GetIntPP("lastVisitedLevel");
        if(sceneToContinue !=0)
        {
        SceneManager.LoadScene(sceneToContinue);
        bl_SceneLoader.GetActiveLoader();
        }
        else
            return;
#else
        sceneToContinue = PlayerPrefs.GetInt("lastVisitedLevel");
        if (sceneToContinue != 0)
        {
            bl_SceneLoaderManager.LoadScene(SceneManager.GetSceneByBuildIndex(sceneToContinue).name);
            bl_SceneLoader.GetActiveLoader();
        }
        else
            return;
#endif
    }

    public void SaveOnCloseAudioOptions()
    {
        SaveBridge.SaveAllData();
    }
}
