*** Settings ***
Documentation       single test for login

Library             SeleniumLibrary
Library             Process


*** Variables ***
${hub}              //div[@class="trading-hub-header__tradershub"]
${dtab}              //div[@data-testid="dt_dropdown_container"]
${demo}             //div[@id="demo"]
${reset}            //div[@tabindex="0"]
${dtrader}          (//div[@class="trading-app-card__actions"]//child::button[@class="dc-btn dc-btn--primary"])[1]
${tab}              //div[@class="cq-symbol-select-btn"]
${derived}          //div[@class="sc-mcd__filter__item sc-mcd__filter__item--selected"]
${synthetic}        //div[@class="sc-mcd__filter__subgroups-item sc-mcd__filter__item--active sc-mcd__filter__item--selected"]
${volatitlty}       (//div[@class="sc-mcd__item__name"])[7]
${tradetype}        //fieldset[@class="trade-container__fieldset trade-types"]
${rise/fall}        //div[@id="dt_contract_rise_fall_item"]
${ticks}            //button[@id="dc_t_toggle_item"]
${5ticks}           //label[@class="range-slider__label"]//child::input[@value="5"]
${stake}            //button[@id="dc_stake_toggle_item"]
${rise}             //button[@class="btn-purchase btn-purchase--1"]

*** Keywords ***
clearInputField
    [Arguments]    @{inputField}
    Press Keys    ${inputField}    CTRL+a+BACKSPACE


*** Test Cases ***
login
    Open Browser    https://app.deriv.com    chrome
    Set Window Size    1280    1024
    Wait Until Page Contains Element    dt_login_button    10
    Click Element    dt_login_button
    Wait Until Page Contains Element    txtEmail    10
    Input Text    txtEmail    email
    Input Password    txtPass    password
    Click Element    //button[@name="login"]

select dtrader
    Wait Until Element Is Visible    ${dtab}
    Click Element    ${dtab}
    Wait Until Element Is Visible    ${demo}
    Click Element    ${demo}
    Wait Until Element Is Visible    ${reset}    10
    Wait Until Element Is Visible    ${dtrader}    10
    Click Element    ${dtrader}
    Wait Until Element Is Visible    //div[@class="stx-subholder"]    20

select volatility 10
    Click Element    ${tab}
    Wait Until Element Is Visible    ${derived}
    Click Element    ${derived}
    Wait Until Element Is Visible    ${volatitlty}
    Click Element    ${volatitlty}

buy contract
    Wait Until Element Is Visible    ${tradetype}
    Click Element    ${tradetype}
    Wait Until Element Is Visible    ${rise/fall}
    Click Element    ${rise/fall}
    Wait Until Page Contains Element    ${ticks}
    Click Element    ${ticks}
    Click Element    ${5ticks}
    Click Element    ${stake}

amount
    Click Element    //input[@id="dt_amount_input"]
    clearInputField    //input[@id="dt_amount_input"]
    Click Element    //input[@id="dt_amount_input"]
    Input Text    //input[@id="dt_amount_input"]    10
    Wait Until Page Contains Element    ${rise}
    Click Element    ${rise}

