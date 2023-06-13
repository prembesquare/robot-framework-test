*** Settings ***
Documentation       single test for login

Library             SeleniumLibrary
Library             XML


*** Variables ***
${hub}                      //div[@class="trading-hub-header__tradershub"]
${dtab}                     //div[@data-testid="dt_dropdown_container"]
${demo}                     //div[@id="demo"]
${reset}                    //div[@tabindex="0"]
${profile}                  //a[@class="trading-hub-header__setting"]
${close_tab}                //div[@id="/account/closing-account"]
${close_account_button}     //button[@class="dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account"]
${checkbox1}                (//label[@class="dc-checkbox closing-account-reasons__checkbox"])[1]
${checkbox2}                (//label[@class="dc-checkbox closing-account-reasons__checkbox"])[2]
${checkbox3}                (//label[@class="dc-checkbox closing-account-reasons__checkbox"])[3]
${checkbox4}                (//label[@class="dc-checkbox closing-account-reasons__checkbox"])[4]
${checkbox5}                (//label[@class="dc-checkbox closing-account-reasons__checkbox"])[5]
${checkbox6}                (//label[@class="dc-checkbox closing-account-reasons__checkbox"])[6]
${checkbox7}                (//label[@class="dc-checkbox closing-account-reasons__checkbox"])[7]
${checkbox8}                (//label[@class="dc-checkbox closing-account-reasons__checkbox"])[8]
${checkbox9}                (//label[@class="dc-checkbox closing-account-reasons__checkbox"])[9]
${checkbox4-disabled}       (//label[@class="dc-checkbox closing-account-reasons__checkbox dc-checkbox--disabled"])[4]
${back}                     //button[@class="dc-btn dc-btn__effect dc-btn--secondary dc-btn__large"]
${cancel}                   //button[@class="dc-btn dc-btn--secondary dc-btn__large closing-account__button--cancel"]
${trader_hub}               //div[@class="trading-hub-header__tradershub"]
${continue_button}          //button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
${other_trading_platform}   //div[@class="dc-input__container"]//textarea[@name="other_trading_platforms"]
${improve}                  //div[@class="dc-input__container"]//textarea[@name="do_to_improve"]
${go_back}                  //div[@class="dc-form-submit-button account-closure-warning-modal__close-account-button dc-form-submit-button--relative"]//child::button[@class="dc-btn dc-btn__effect dc-btn--secondary dc-btn__large"]
${confirm_close_button}     //div[@class="dc-form-submit-button account-closure-warning-modal__close-account-button dc-form-submit-button--relative"]//child::button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
${login}                    //button[@id="dm-nav-login-button"]
${email}                    //input[@id="txtEmail"]
${password}                 //input[@id="txtPass"]
${login_deriv.com}          //button[@name="login"]
${resp_trading}             //a[text()="Responsible trading"]
${start_trading}            //button[@name="confirm_reactivate"]
${deposit}                  //button[@class="dc-btn dc-btn__effect dc-btn--primary acc-info__button"]


*** Keywords ***
clearInputField
    [Arguments]    @{inputField}
    Press Keys    ${inputField}    CTRL+a+BACKSPACE

*** Test Cases ***
login
    Open Browser    https://app.deriv.com    chrome
    Set Window Size    1920    1080
    Wait Until Page Contains Element    dt_login_button    10
    Click Element    dt_login_button
    Wait Until Page Contains Element    txtEmail    10
    Input Text    txtEmail    email
    Input Password    txtPass    password
    Click Element    //button[@name="login"]

select profile
    Wait Until Element Is Visible    ${dtab}    20
    Click Element    ${dtab}
    Wait Until Element Is Visible    ${demo}
    Click Element    ${demo}
    Wait Until Element Is Visible    ${reset}    20
    Click Element    ${profile}

select close account
    Wait Until Page Contains Element    ${close_tab}    20
    Click Element    ${close_tab}
    Wait For Condition	return document.readyState == "complete"
    Click Element    ${close_account_button}

check if error message appear
    Wait Until Page Contains Element    ${checkbox1}    20
    Click Element    ${checkbox1}
    Click Element    ${checkbox1}
    Page Should Contain    Please select at least one reason
    Element Should Be Disabled    ${continue_button}
    Click Element    ${checkbox1}
    Click Element    ${checkbox2}
    Click Element    ${checkbox3}
    Page Should Contain Element    ${checkbox4-disabled}

check back button
    Click Element    ${back}
    Wait For Condition	return document.readyState == "complete"
    Click Element    ${close_account_button}

check cancel button
    Click Element    ${back}
    Wait For Condition	return document.readyState == "complete"
    Click Element    ${cancel}
    Wait For Condition	return document.readyState == "complete"
    Wait Until Page Contains Element    ${trader_hub}    10
    Click Element    ${trader_hub}
    Wait Until Element Is Visible    ${dtab}    20
    Click Element    ${dtab}
    Wait Until Element Is Visible    ${reset}    20
    Click Element    ${profile}
    Wait Until Page Contains Element    ${close_tab}    20
    Click Element    ${close_tab}
    Wait For Condition	return document.readyState == "complete"
    Click Element    ${close_account_button}

select checkbox reason
    Click Element    ${checkbox1}
    Click Element    ${checkbox2}
    Click Element    ${checkbox3}
    Page Should Contain Element    ${checkbox4-disabled}

check for textbox invalid input
    Click Element    ${other_trading_platform}
    Input Text    ${other_trading_platform}    !
    Page Should Contain    Must be numbers, letters, and special characters . , ' -

insert text in textbox
    Click Element    ${other_trading_platform}
    clearInputField    ${other_trading_platform}
    Input Text    ${other_trading_platform}    No other platform
    Click Element    ${improve}
    Input Text    ${improve}    Nothing to improve

close account
    Click Element    ${continue_button}
    Wait Until Page Contains Element    ${go_back}
    Click Element    ${go_back}
    Wait Until Page Contains Element    ${continue_button}
    Click Element    ${continue_button}
    Wait Until Page Contains Element    ${confirm_close_button}
    Click Element    ${confirm_close_button}
    Wait For Condition	return document.readyState == "complete"

reactivate account
    Wait Until Element Is Enabled    ${login}    30
    Click Element    ${login}
    Wait For Condition	return document.readyState == "complete"
    Click Element    ${email}
    Input Text    ${email}    email
    Click Element    ${password}
    Input Text    ${password}    password
    Click Element    ${login_deriv.com}
    Wait For Condition	return document.readyState == "complete"
    Page Should Contain Element    ${resp_trading}
    Click Element    ${start_trading}
    Wait For Condition	return document.readyState == "complete"
    Page Should Contain Element    ${deposit}


