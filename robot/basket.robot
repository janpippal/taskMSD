*** Settings ***
Documentation       Navigating to czc.cz getting category view, sorting by price descending, taking two products into a basket and comparing the price there is the same as on view
Library           SeleniumLibrary

*** Variables ***
#could be in separate file if needed
${navbarMobilyTabletyCategory}     //div[@class="main-menu__dep"][descendant::*[contains(.,"Mobily, tablety")]]
${navbarMobilniTelefonySubcategory}  //*[@href="/mobilni-telefony/produkty"][contains(@class,"main-menu__item")]
${selectionCategoryStolniSeSim}    //*[@href="/stolni-se-sim-mobilni-telefony/produkty"][contains(@class,"scard")]
${dataOrderByPriceDesc}    //li[@data-order-by="PRICE"][@data-direction="DESC"]
${leftMenuFilterAvailable}    //*[@data-constraint-id="availability"]//span[text()="skladem"]
${productTile}    //*[@class="new-tile"]
${tilePrice}    //span[@class="price-vatin"]
${tileTitle}    //div[@class="tile-title"]

*** Test Cases ***
Verify price for two most expensive products in the list and in shopping basket
    [Setup]    Open Browser  http:\\czc.cz    chrome
    Maximize Browser Window
    Accept cookies window
    Navigate down to a subcategory 
    Order by most expensive
    Filter by only available products
    Save two most expensive products title and price
    Put two most expensive products in the basket    
    Verify titles and prices of two most expensive products in the basket
    [Teardown]    Close All Browsers

*** Keywords ***
Click and wait for element
    [Arguments]  ${element}
    Get rid of annoying chat window that blocks clicking
    Wait Until Page Contains Element    ${element}
    Wait Until Keyword Succeeds    10    2s        Click Element    ${element}

Get rid of annoying chat window that blocks clicking
    ${countOfChatWindow}=    Get element count  //*[@data-testid="wb-teaser"]//button
    Run keyword if    ${countOfChatWindow} > 0    Click element    //*[@data-testid="wb-teaser"]//button

Accept cookies window
    Click and wait for element    //button[contains(@class,"js-all-cookies")]

Navigate down to a subcategory 
    Click and wait for element    ${navbarMobilyTabletyCategory}
    Click and wait for element    ${navbarMobilniTelefonySubcategory}
    Click and wait for element    ${selectionCategoryStolniSeSim}
 
 Order by most expensive
     Click and wait for element    ${dataOrderByPriceDesc}
     Wait Until Page Contains Element    ${dataOrderByPriceDesc}\[descendant::*[@class="active"]]

Filter by only available products
    Click and wait for element    ${leftMenuFilterAvailable}

Put two most expensive products in the basket
    Click and wait for element    //*[@class="new-tile"][1]//button[contains(@class,"btn-buy")]
    Click and wait for element    //button[contains(@class,"close")]
    Click and wait for element    //*[@class="new-tile"][2]//button[contains(@class,"btn-buy")]
    Click and wait for element    //*[@href="https://www.czc.cz/kosik"]

Save two most expensive products title and price    
    ${text}=    Get Text  ${productTile}\[1]${tilePrice}
    Set Test Variable    $firstExpensiveProductPrice    ${text}
    ${text}=    Get Text  ${productTile}\[1]${tileTitle}
    Set Test Variable    $firstExpensiveProductTitle    ${text}
    ${text}=   Get Text  ${productTile}\[2]${tilePrice}
    Set Test Variable    $secondExpensiveProductPrice    ${text}
    ${text}=   Get Text  ${productTile}\[2]${tileTitle}
    Set Test Variable    $secondExpensiveProductTitle    ${text}
    Capture Page Screenshot

Verify titles and prices of two most expensive products in the basket
    Element Text Should Be    css=.op-item:nth-of-type(1) .product-name a    ${firstExpensiveProductTitle}
    Element Text Should Be    css=.op-item:nth-of-type(1) .price-sum .price-vatin .money-part    ${firstExpensiveProductPrice}
    Element Text Should Be    css=.op-item:nth-of-type(2) .product-name a    ${secondExpensiveProductTitle}
    Element Text Should Be    css=.op-item:nth-of-type(2) .price-sum .price-vatin .money-part    ${secondExpensiveProductPrice}