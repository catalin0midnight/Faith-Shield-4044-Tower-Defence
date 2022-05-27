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
    [SerializeField] private GameObject newGameLayout;
    [SerializeField] private GameObject loadGameLayout;
    [SerializeField] private GameObject optionsLayout;
    [SerializeField] private GameObject exitLayout;
    [SerializeField] private Button newGameButton;
    [SerializeField] private Button loadGameButton;
    [SerializeField] private Button optionsButton;
    [SerializeField] private Button exitButton;

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
        if (newGameLayout.activeSelf == true)
        {
            newGameButton.interactable = false;
            loadGameButton.interactable = false;
            optionsButton.interactable = false;
            exitButton.interactable = false;
        }
        if (loadGameLayout.activeSelf == true)
        {
            newGameButton.interactable = false;
            loadGameButton.interactable = false;
            optionsButton.interactable = false;
            exitButton.interactable = false;
        }
        if (optionsLayout.activeSelf == true)
        {
            newGameButton.interactable = false;
            loadGameButton.interactable = false;
            optionsButton.interactable = false;
            exitButton.interactable = false;
        }
        if (exitLayout.activeSelf == true)
        {
            newGameButton.interactable = false;
            loadGameButton.interactable = false;
            optionsButton.interactable = false;
            exitButton.interactable = false;
        }
    }

    private void ClosingMenuLayouts()
    {
        if (player.GetButtonDown("Cancel") && newGameLayout.activeSelf == true)
        {
            newGameLayout.SetActive(false);
            newGameButton.Select();
            newGameButton.interactable = true;
            loadGameButton.interactable = true;
            optionsButton.interactable = true;
            exitButton.interactable = true;
        }
        if (player.GetButtonDown("Cancel") && loadGameLayout.activeSelf == true)
        {
            loadGameLayout.SetActive(false);
            loadGameButton.Select();
            newGameButton.interactable = true;
            loadGameButton.interactable = true;
            optionsButton.interactable = true;
            exitButton.interactable = true;
        }
        if (player.GetButtonDown("Cancel") && optionsLayout.activeSelf == true)
        {
            optionsLayout.SetActive(false);
            optionsButton.Select();
            newGameButton.interactable = true;
            loadGameButton.interactable = true;
            optionsButton.interactable = true;
            exitButton.interactable = true;
        }
        if (player.GetButtonDown("Cancel") && exitLayout.activeSelf == true)
        {
            exitLayout.SetActive(false);
            exitButton.Select();
            newGameButton.interactable = true;
            loadGameButton.interactable = true;
            optionsButton.interactable = true;
            exitButton.interactable = true;
        }

        if(exitLayout.activeSelf == false)
        {
            newGameButton.interactable = true;
            loadGameButton.interactable = true;
            optionsButton.interactable = true;
            exitButton.interactable = true;
        }
    }

    public void StartGame()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
    }

    public void QuitGame()
    {
        Application.Quit();
        Debug.Log("Application closed");
    }
}
