*** Settings ***
Documentation       single test for login

Library             SeleniumLibrary
Library             Process


*** Variables ***
${hub}                              //div[@class="trading-hub-header__tradershub"]
${dtab}                             //div[@data-testid="dt_dropdown_container"]
${demo}                             //div[@id="demo"]
${reset}                            //div[@tabindex="0"]
${dtrader}                          (//div[@class="trading-app-card__actions"]//child::button[@class="dc-btn dc-btn--primary"])[1]
${tab}                              //div[@class="cq-symbol-select-btn"]
${derived}                          //div[@class="sc-mcd__filter__item sc-mcd__filter__item--selected"]
${synthetic}                        //div[@class="sc-mcd__filter__subgroups-item sc-mcd__filter__item--active sc-mcd__filter__item--selected"]
${volatitlty}                       (//div[@class="sc-mcd__item__name"])[11]
${tradetype}                        //fieldset[@class="trade-container__fieldset trade-types"]
${multiplier}                       //div[@id="dt_contract_multiplier_item"]
${payout}                           //button[@id="dc_payout_toggle_item"]
${take_profit}                      //label[@for="dc_take_profit-checkbox_input"]
${stop_loss}                        //label[@for="dc_stop_loss-checkbox_input"]
${deal_cancellation}                //label[@for="dt_cancellation-checkbox_input"]
${take_profit_disabled}             //span[@class="dc-checkbox__box"]//following::span[text()="Take profit"]
${stop_loss_disabled}               //span[@class="dc-checkbox__box"]//following::span[text()="Stop loss"]
${deal_cancellation_disabled}       //span[@class="dc-checkbox__box"]//following::span[text()="Deal cancellation"]
${multiplier_tab}                   //div[@class="dc-dropdown__display dc-dropdown__display--no-border"]
${multiplier_20}                    (//div[@data-testid="dti_list_item"])[1]
${multiplier_40}                    (//div[@data-testid="dti_list_item"])[2]
${multiplier_60}                    (//div[@data-testid="dti_list_item"])[3]
${multiplier_100}                   (//div[@data-testid="dti_list_item"])[4]
${multiplier_200}                   (//div[@data-testid="dti_list_item"])[5]
${amount}                           //input[@id="dt_amount_input"]
${deal_cancellation_fee}            (//div[@class="trade-container__price-info-value"])[1]
${take_profit_amount}               //input[@id="dc_take_profit_input"]
${add}                              //button[@id="dc_take_profit_input_add"]
${check_increase_1}                 //input[@id="dc_take_profit_input" and @value="101"]
${minus}                            //button[@id="dc_take_profit_input_sub"]
${check_decrease_1}                 //input[@id="dc_take_profit_input" and @value="100"]
${deal_cancellation_tab}            //div[@class="dc-dropdown__display dc-dropdown__display--no-border"]//span[@name="cancellation_duration"]
${5_minute}                         //div[@data-testid="dti_list_item" and @id="5m"]
${10_minute}                        //div[@data-testid="dti_list_item" and @id="10m"]
${15_minute}                        //div[@data-testid="dti_list_item" and @id="15m"]
${30_minute}                        //div[@data-testid="dti_list_item" and @id="30m"]
${60_minute}                        //div[@data-testid="dti_list_item" and @id="60m"]


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

select volatility 50
    Click Element    ${tab}
    Wait Until Element Is Visible    ${derived}
    Click Element    ${derived}
    Wait Until Element Is Visible    ${volatitlty}
    Click Element    ${volatitlty}

select multiplier
    Wait Until Element Is Visible    ${tradetype}
    Click Element    ${tradetype}
    Wait Until Element Is Visible    ${multiplier}
    Click Element    ${multiplier}
    Page Should Not Contain Element    ${payout}

select type of deal
    Click Element    ${take_profit}
    Click Element    ${stop_loss}
    Page Should Contain Element    ${deal_cancellation_disabled}
    Click Element    ${deal_cancellation}
    Page Should Contain Element    ${take_profit_disabled}
    Page Should Contain Element    ${stop_loss_disabled}

check multiplier value
    Click Element    ${multiplier_tab}
    Wait Until Element Is Visible    ${multiplier_20}    10
    Page Should Contain Element    ${multiplier_20}
    Page Should Contain Element    ${multiplier_40}
    Page Should Contain Element    ${multiplier_60}
    Page Should Contain Element    ${multiplier_100}
    Page Should Contain Element    ${multiplier_200}

check deal cancellation fee
    Click Element    ${amount}
    clearInputField    ${amount}
    Click Element    ${amount}
    Input Text    ${amount}    10
    Wait Until Element Is Visible    ${deal_cancellation_fee}
    ${string_10}    Get Text    ${deal_cancellation_fee}
    ${value_10}    Set Variable    ${string_10[:-4]}
    Log To Console    ${value_10}
    Click Element    ${amount}
    clearInputField    ${amount}
    Click Element    ${amount}
    Input Text    ${amount}    100
    Wait Until Element Is Visible    ${deal_cancellation_fee}
    ${string_100}    Get Text    ${deal_cancellation_fee}
    ${value_100}    Set Variable    ${string_100[:-4]}
    Log To Console    ${value_10}
    Should Be True    ${value_100} > ${value_10}

check max, min stake
    Click Element    ${amount}
    clearInputField    ${amount}
    Click Element    ${amount}
    Input Text    ${amount}    2001
    Sleep    2
    Page Should Contain    Maximum stake allowed is 2000.00.
    Click Element    ${amount}
    clearInputField    ${amount}
    Click Element    ${amount}
    Input Text    ${amount}    0
    Sleep    2
    Page Should Contain    Please enter a stake amount that's at least 1.00.

check if increase, decrease by 1 value
    Click Element    ${take_profit}
    Click Element    ${take_profit_amount}
    clearInputField    ${take_profit_amount}
    Click Element    ${take_profit_amount}
    Input Text    ${take_profit_amount}    100
    Click Element    ${add}
    Page Should Contain Element    ${check_increase_1}
    Click Element    ${minus}
    Page Should Contain Element    ${check_decrease_1}

check deal cancellation duration
    Click Element    ${deal_cancellation}
    Click Element    ${deal_cancellation_tab}
    Wait Until Element Is Visible    ${5_minute}    10
    Page Should Contain Element    ${5_minute}
    Page Should Contain Element    ${10_minute}
    Page Should Contain Element    ${15_minute}
    Page Should Contain Element    ${30_minute}
    Page Should Contain Element    ${60_minute}
