
*** Settings ***
Documentation  A resource file containing the application specific keywords
Library   Selenium2Library

*** Variables ***
Radiobtn_3    //*[@id="radio-btn-example"]//label[contains(.,'Radio3')]
Radiobtn_2    //*[@id="radio-btn-example"]//label[contains(.,'Radio2')]
Radiobtn_1    //*[@id="radio-btn-example"]//label[contains(.,'Radio1')]
Hidebtn    //*[@id="hide-textbox"][contains(@value,'Hide')]
Showbtn    //*[@id="show-textbox"][contains(@value,'Show')]
Show-HideTxtBx    //*[@id="displayed-text"][contains(@placeholder,'Hide/Show Example')]
checkbox_1    //*[@id="checkbox-example"]/fieldset/label[contains(.,'Option1')]
checkbox_2    //*[@id="checkbox-example"]/fieldset/label[contains(.,'Option2')]
checkbox_3    //*[@id="checkbox-example"]/fieldset/label[contains(.,'Option3')]
Suggestion_txtfld    //*[@id="autocomplete"][contains(@placeholder,'Type to Select Countries')]
Country_SouthAfrica    //*[@id="ui-id-1"]/li[contains(.,'South Africa')]
First_Country    //*[@id="ui-id-1"]/li[1]
Drobdown_example    //*[@id="dropdown-class-example"][contains(@name,'dropdown-class-example')]
Postman_data_element    //*[@id="product"]/tbody/tr[contains(.,'Joe') and contains(.,'Postman') and contains(.,'Chennai') and contains(.,'46')]
Total_amount_element    /html/body/div[3]/div[2]/fieldset[2]/div[contains(.,'Total Amount Collected: 296')]
Iframe_s_element    //iframe[@id="courses-iframe"]
Iframe_element    //*[@id="courses-iframe"]
Iframe_LatestNews_footer    //*[@id="gf-BIG"]/table/tbody/tr/td[2]/ul/li[1]/h3/a[contains(.,'News')]
Checkbox_collection    //*[@id="checkbox-example"]/fieldset/legend[contains(.,'Checkbox')]
Radio_collection    //*[@id="radio-btn-example"]/fieldset/legend[contains(.,'Radio Button')]
WebTable_FixedHeader    /*//fieldset[contains(.,'Web Table Fixed header')]/div/table/tbody/tr/td[4]
Iframe_HomeNav_btn    /html/body/div/header/div[3]/div/div/div[2]/nav/div[2]/ul/li[1]/a[contains(.,'Home')]

*** Test Cases ***
Check out joe colantonio dot com
    Open Browser    https://rahulshettyacademy.com/AutomationPractice   chrome
    Close Browser

Interact with radio buttons
	Click element    Radiobtn_3
	Capture Element Screenshot    Radio_collection    radio-button-collection.png
	//validate only 1 radio button is checked
	Click element    Radiobtn_2
	Capture Element Screenshot    Radio_collection    radio-button-collection.png
    //validate only radio button 2 is checked

Interact with suggestion class example
	Input text    Suggestion_txtfld    South
	Click element    Country_SouthAfrica
	Clear Element Text   Suggestion_txtfld
	Input text    Suggestion_txtfld    Republic
	Click element    First_Country

Interact with checkboxes
    Click element    checkbox_1
    Click element    checkbox_2
    Click element    checkbox_3
    Click element    checkbox_1
    Capture Element Screenshot    Checkbox_collection    checkbox-collection.png
    //Validate the other two boxes stay checked

Interact with show and hide buttons
	Page Should Contain Element       Show-HideTxtBx
    Click element    Hidebtn
    Wait Until Page Does Not Contains Element       Show-HideTxtBx     5
    Click element    Showbtn
    Wait Until Page Contains Element       Show-HideTxtBx    5


Interact with webtable fixed header
    Page should contain element    Postman_data_element
    Page should contain element    Total_amount_element
    Get Total Count of Element Data
    //Loop through all values and add the sum, verify the sum is correct

Interact with web Iframe
    Page Should Contain Element       Iframe_HomeNav_btn
    Click element    Iframe_HomeNav_btn
    Wait Until Page Contains Element    Iframe_LatestNews_footer    5
    Click element    Iframe_LatestNews_footer

*** Keywords ***
Get Total Count of Element Data
    ${rows} =    Get Element Count    /*//fieldset[contains(.,'Web Table Fixed header')]/div/table/tbody/tr/td[4]

    FOR    ${row_num}    IN RANGE    ${rows}
            Wait Until Element Is Visible    /*//fieldset[contains(.,'Web Table Fixed header')]/div/table/tbody/tr[${row_num}]/td[4]
            ${text} =    Get Element Attribute    /*//fieldset[contains(.,'Web Table Fixed header')]/div/table/tbody/tr[${row_num}]/td[4]
            ${Num1} =    Convert To Integer   ${text.split()[0]}
            ${Sum} =    Evaluate    ${Sum} + ${Num1}
            Log    Latest total amount: ${Sum}
    END