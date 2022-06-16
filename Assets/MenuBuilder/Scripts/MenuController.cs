using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using Rewired;
using System;

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

    private int sceneToContinue;

    private void Awake()
    {
        player = ReInput.players.GetPlayer(playerID);
    }

    private void FixedUpdate()
    {
        FadingMenuButtons();
        ClosingMenuLayouts();
    }

    private void FadingMenuButtons()
    {
        if (optionsLayout.activeSelf == true)
        {
            newGameButton.interactable = false;
            continueGameButton.interactable = false;
            optionsButton.interactable = false;
        }
    }

    private void ClosingMenuLayouts()
    {
        if (player.GetButtonDown("Cancel") && optionsLayout.activeSelf == true)
        {
            optionsLayout.SetActive(false);
            optionsButton.Select();
            newGameButton.interactable = true;
            continueGameButton.interactable = true;
            optionsButton.interactable = true;
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
}
