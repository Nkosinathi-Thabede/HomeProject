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
Iframe_element_interact    //*[@id="gf-BIG"]/table/tbody/tr/td[2]/ul/li[1]/h3/a[contains(.,'News')]


*** Test Cases ***
Check out joe colantonio dot com
 Open Browser    https://testguild.com    ff
 Close Browser

Interact with radio buttons
	Click element    Radiobtn_3
	//validate only 1 radio button is checked
	Click element    Radiobtn_2
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
    //Validate the other two boxes stay checked

Interact with show and hide buttons
	Page Should Contain Element       Show-HideTxtBx
    Click element    Hidebtn
    Page Should Not Contain Element       Show-HideTxtBx
    Click element    Showbtn
    Page Should Contain Element       Show-HideTxtBx


Interact with webtable fixed header
    Page should contain element    Postman_data_element
    Page should contain element    Total_amount_element
    //Loop through all values and add tha sum
Interact with web Iframe
