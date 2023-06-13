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
${api_token}                //a[@id="dc_api-token_link"]
${token_name}               //input[@name="token_name"]
${read}                     //input[@name="read"]//parent::label
${trade}                    //input[@name="trade"]//parent::label
${payment}                  //input[@name="payments"]//parent::label
${trading_info}             //input[@name="trading_information"]//parent::label
${admin}                    //input[@name="admin"]//parent::label
${error_msg}                //div[@class="dc-field dc-field--error"]
${create}                   //button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button"]
${row}                      //tr[@class="da-api-token__table-cell-row"]
${token_row}                //td[@class="da-api-token__table-cell da-api-token__table-cell--name"]
${copy}                     (//td[@class="da-api-token__table-cell"]/div/div[@data-testid="dt_popover_wrapper"])[1]
${view}                     (//td[@class="da-api-token__table-cell"]/div/div[@data-testid="dt_popover_wrapper"])[2]
${admin_copy_warning}       //div[@class="dc-modal-body"]
${copy_ok}                  //button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button"]
${check_read}               //div[@class="da-api-token__table-scope-cell" and text()="Read"]
${check_trade}              //div[@class="da-api-token__table-scope-cell" and text()="Trade"]
${check_payment}            //div[@class="da-api-token__table-scope-cell" and text()="Payments"]
${check_trading_info}       //div[@class="da-api-token__table-scope-cell" and text()="Trading information"]
${check_admin}              //div[@class="da-api-token__table-scope-cell da-api-token__table-scope-cell-admin" and text()="Admin"]
${check_status}             //span[@class="dc-text" and text()="Never"]
${delete}                   (//div[@data-testid="dt_popover_wrapper"])[6]//parent::td
${delete_popup}             //div[@class="dc-modal"]
${delete_button}            //button[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button"]


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
    Input Text    txtEmail    prem+14@besquare.com.my
    Input Password    txtPass    Mywork1234
    Click Element    //button[@name="login"]

select profile
    Wait Until Element Is Visible    ${dtab}    20
    Click Element    ${dtab}
    Wait Until Element Is Visible    ${demo}
    Click Element    ${demo}
    Wait Until Element Is Visible    ${reset}    20
    Click Element    ${profile}

select api token
    Wait Until Element Is Visible    ${api_token}    20
    Click Element    ${api_token}
    Wait Until Element Is Visible    ${token_name}    20

create token with all scopes except admin
    Wait For Condition	return document.readyState == "complete"
    Wait Until Page Contains Element    ${read}    20
    Click Element    ${read}
    Click Element    ${trade}
    Click Element    ${payment}
    Click Element    ${trading_info}
    Click Element    ${token_name}
    Input Text    ${token_name}    T
    Wait For Condition	return document.readyState == "complete"
    Wait Until Element Is Visible    ${error_msg}    20
    clearInputField    ${token_name}
    Wait Until Element Is Visible    ${token_name}    20
    Click Element    ${token_name}
    Wait For Condition	return document.readyState == "complete"
    Input Text    ${token_name}    Token1
    Wait Until Element Is Visible    ${create}    20
    Wait For Condition	return document.readyState == "complete"
    Click Element    ${create}

do action for token
    Wait For Condition	return document.readyState == "complete"
    Wait Until Element Is Visible    ${copy}    20
    Click Element    ${copy}
    Click Element    ${view}
    Page Should Contain Element    ${check_read}
    Page Should Contain Element    ${check_trade}
    Page Should Contain Element    ${check_payment}
    Page Should Contain Element    ${check_trading_info}
    Page Should Contain Element    ${check_status}
    Sleep    2
    Wait Until Element Is Visible    ${delete}    20
    Wait For Condition	return document.readyState == "complete"
    Sleep    2
    Click Element    ${delete}
    Sleep    2
    Wait Until Element Is Visible    ${delete_button}    20
    Click Element    ${delete_button}

create token with all scopes including admin
    Wait For Condition	return document.readyState == "complete"
    Click Element    ${read}
    Click Element    ${trade}
    Click Element    ${payment}
    Click Element    ${trading_info}
    Click Element    ${admin}
    Click Element    ${token_name}
    Input Text    ${token_name}    Admin1
    Wait Until Element Is Visible    ${create}    20
    Wait For Condition	return document.readyState == "complete"
    Click Element    ${create}

do action for token with admin token
    Wait For Condition	return document.readyState == "complete"
    Wait Until Element Is Visible    ${token_row}    20
    Click Element    ${copy}
    Wait Until Element Is Visible    ${admin_copy_warning}    20
    Wait For Condition	return document.readyState == "complete"
    Click Element    ${copy_ok}
    Wait Until Element Is Visible    ${view}    10
    Click Element    ${view}
    Wait Until Element Is Visible    ${check_read}    20
    Wait Until Element Is Visible    ${check_trade}    20
    Wait Until Element Is Visible    ${check_payment}    20
    Wait Until Element Is Visible    ${check_trading_info}    20
    Wait Until Element Is Visible    ${check_admin}    20
    Wait Until Element Is Visible    ${check_status}    20
    Click Element    ${delete}
    Wait For Condition	return document.readyState == "complete"
    Click Element    ${delete_button}