*** Settings ***
Documentation       single test for login

Library             SeleniumLibrary
Library             Process


*** Variables ***
${hub}              //div[@class="trading-hub-header__tradershub"]
${dtab}             //div[@data-testid="dt_dropdown_container"]
${demo}             //div[@id="demo"]
${reset}            //div[@tabindex="0"]
${dtrader}          (//div[@class="trading-app-card__actions"]//child::button[@class="dc-btn dc-btn--primary"])[1]
${tab}              //div[@class="cq-symbol-select-btn"]
${forex}            //span[@class="ic-icon ic-forex"]//parent::div
${aud/usd}          //div[@class="sc-mcd__item sc-mcd__item--frxAUDUSD "]
${tradetype}        //fieldset[@class="trade-container__fieldset trade-types"]
${higher/lower}     //div[@id="dt_contract_high_low_item"]
${duration}         //button[@id="dc_duration_toggle_item"]
${dayscont}         //div[@class="dc-input__container"]//child::input
${barrier}          //input[@class="input trade-container__input trade-container__barriers-input trade-container__barriers-single-input" and @value!="${EMPTY}"]
${payout}           //button[@id="dc_payout_toggle_item"]
${payoutAmt}        //div[@class="dc-input-wrapper"]//child::input
${lower}            //button[@id="dt_purchase_put_button"]


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

select aud/usd
    Click Element    ${tab}
    Wait Until Element Is Visible    ${forex}
    Click Element    ${forex}
    Wait Until Element Is Visible    ${aud/usd}
    Click Element    ${aud/usd}

select trade type
    Wait Until Element Is Visible    ${tradetype}
    Click Element    ${tradetype}
    Wait Until Element Is Visible    ${higher/lower}
    Click Element    ${higher/lower}

choose duration
    Click Element    ${duration}
    Click Element    ${dayscont}
    clearInputField    ${dayscont}
    Click Element    ${dayscont}
    Input Text    ${dayscont}    2

check barrier
    Wait Until Element Is Visible    ${barrier}

choose amount
    Click Element    ${payout}
    Click Element    ${payoutAmt}
    clearInputField    ${payoutAmt}
    Click Element    ${payoutAmt}
    Input Text    ${payoutAmt}    15.50
    Sleep    2
    Click Element    ${lower}
