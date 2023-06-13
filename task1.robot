*** Settings ***
Documentation    single test for login
Library    SeleniumLibrary
Library    Process

*** Variables ***
${hub}    //div[@class="trading-hub-header__tradershub"]
${regulation}    //div[@class="regulators-switcher--text"]
${tab}    //div[@data-testid="dt_dropdown_container"]
${demo}    //div[@id="demo"]
${reset}    //div[@tabindex="0"]
${real}    //div[@id="real"]

*** Test Cases ***
login
    Open Browser    https://app.deriv.com     chrome
    Set Window Size    1280    1024
    Wait Until Page Contains Element    dt_login_button    10
    Click Element    dt_login_button
    Wait Until Page Contains Element    txtEmail    10
    Input Text     txtEmail    email
    Input Password    txtPass    password
    Click Element    //button[@name="login"]
    Wait Until Element Is Visible    ${regulation}    10
    Click Element    ${tab}
    Wait Until Element Is Visible    ${demo}
    Click Element    ${demo}
    Wait Until Element Is Visible    ${reset}    10