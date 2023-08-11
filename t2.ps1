$userName1 = "a1"
$userName2 = "a2"

$YamafudaArray = @( @(1, 2, 3, 4, 5, 6), @(7, 8),  @(11))
$YamafudaNames = @( "a1", "b2", "c3")

$cardsAndImage = @{ 1 = "a1.png"
                    2 = "a2.png"
                    3 = "a3.png"
                    4 = "a4.png"
}

$cards = @{ 1 =  @("P1", "P2");
            2 =  @();
            3 =  @("P5", "P8");
            4 =  @(); }



function addPin($cardsId, $pinName){
    $ar1 = $script:cards[$cardsId]
    $ar1 += $pinName

    $script:cards[$carsId] = $ar1
    
}
<#一枚のカードのピンを外す #>
function deletePin($CardsId, $pinName){
    $ar1 = $script:cards[$cardsId]

    $ar2 = @()
    for($idx=0; $idx -lt $ar1.Count; $idx++){
        if($ar1[$idx] -ne $pinName){
            $ar2 += $ar1[$idx]
        }
    }

    $script:cards[$carsId] = $ar2

}

<#全体の中で指定したピンをすべて外す#>
function deleteAllPin($pinName){
    $cardsKeys = $script:cards.Keys

    foreach($key1 in $cardsKeys){
        $ar1 = $script:cards[$key1]

        $ar2 = @()
        for($idx = 0; $idx -lt $ar1.Count; $idx++){
            if($ar1[$idx] -ne $pinName){
                $ar2 += $ar1[$idx]
            }
        }

        $script:cards[$key1] = $ar2
    }

}

function OutputImage($URLList, $FormSize, $cardSize, $Pos){
    #フォーム
    $form = New-Object System.Windows.Forms.Form 
    $form.Text = "イメージテスト"
    $form.Size = New-Object System.Drawing.Size($FormSize[0], $FormSize[1]) 
    $form.StartPosition = "CenterScreen"
 
    $px = $Pos[0]
    $py = $Pos[1]
    $picList = @();
    for($idx = 0; $idx -lt $URLList.Count; $idx++){

        $imgURL = $URLList[$idx]
        #PictureBox
        $pic = New-Object System.Windows.Forms.PictureBox
        $pic.Size = New-Object System.Drawing.Size($cardSize[0], $cardSize[1])
        $pic.Image = [System.Drawing.Image]::FromFile($imgURL)
        $pic.Location = New-Object System.Drawing.Point($px,$py) 
        $pic.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom
        $form.Controls.Add($pic) 

        $px += $cardSize[0]

        $picList += $pic
    }

 
    #フォームを表示
    $result = $form.ShowDialog()


    foreach($picList in $pic1){
        #リソースを開放
        $pic1.Image.Dispose()
        $pic1.Image = $null
    }

    
}

function PeekYamafuda($name1, $idxList){
    $Y1 = getYamafuda $name1

    $Y2 = @()
    for($idx = 0; $idx -lt $idxList.Count; $idx++){
        $Y2 += $Y1[$idxList[$idx]];
    }

    write-host "見ているカードのIDリスト:" + $Y2

    $URLList = @()
    for($idx2=0;  $idx2 -lt $Y2.Count; $idx2++){
        $URLList += $cardsAndImage[$Y2[$idx2]]
    }

    $FWidth = 100 * $Y2.Count + 50
    $FHight = 150
    $CWidth = 100
    $CHight = 100
    $PosX=20
    $PosY=20

    outputImage $URLList @($FWidth, $FHight) @($CWidth, $CHight) @($PosX, $PosY)

    
}

function startTurn($name1){
    write-host $name1 + "のユーザのターンを開始します"
}

function exeCard($name1, $idx){
    $Y1 = getYamafuda $name1
    $C1 = $Y1[$idx]

    write-host "見ているカードのID:" + $C1

    $URLList = @($cardsAndImage[$C1]);

    $FWidth = 100 * $Y2.Count + 50
    $FHight = 150
    $CWidth = 100
    $CHight = 100
    $PosX=20
    $PosY=20

    outputImage $URLList @($FWidth, $FHight) @($CWidth, $CHight) @($PosX, $PosY)
    
}

function inputUserName($name1, $name2){

    $script:userName1 = $name1
    $script:userName2 = $name2
}

function addYamafuda($name1){
    $script:YamafudaArray += @()
    $script:YamafudaNames += $name1
}

function addYamafuda2($name1, $card1){
    addYamafuda $name1

    $idx1 = getYamafudaIdx($name1)
    $script:YamafudaArray[$idx] = $card1

}


function deleteYamafuda($name1){

    $Y1 = ""
    $YN1 = ""
    for($idx1=0; $idx1 -lt $Script:YamafudaNames.Length; $idx1++){

        if($Script:YamafudaNames[$idx1] -eq $name1){
            $Y1 = $Script:YamafudaArray[0..$idx1]
            $YN1 = $Script:YamafudaNames[0..$idx1]

            $Y1  += $Script:YamafudaArray[$idx1 + ($Script:YamafudaNames.Length-1)]
            $YN1 += $Script:YamafudaNames[$idx1 + ($Script:YamafudaNames.Length-1)]
            
        }
    }

    $Script:YamafudaArray = $Y1
    $Script.YamafudaNames = $YN1



}

function getYamafuda($name1){
    for($idx1=0; $idx1 -lt $Script:YamafudaNames.Length; $idx1++){

        if($Script:YamafudaNames[$idx1] -eq $name1){
               return ($Script:YamafudaArray[$idx1])
        }
    }    
}

function getYamafudaIdx($name1){
    for($idx1=0; $idx1 -lt $Script:YamafudaNames.Length; $idx1++){

        if($Script:YamafudaNames[$idx1] -eq $name1){
               return ($idx1)
        }
    }    
}

function suffleYamafuda($name1){
    $Y1 = getYamafuda $name1
    $idx1 = getYamafudaIdx($name1)

    $Y1 = Get-Random $Y1 -Count $Y1.Length

    $script:YamafudaArray[$idx1] = $Y1

}

function MargeYamafuda($name1, $name2, $ord, $name3){
    $Y1 = getYamafuda $name1
    $idx1 = getYamafudaIdx($name1)

    $Y2 = getYamafuda $name2
    $idx2 = getYamafudaIdx($name2)


    $Y3 = @();

    if($ord -eq "normal"){
        $Y3 = $Y1
        $Y3 += $Y2
    }elseif($ord -eq "reverse"){
        $Y3 = [array]::Reverse( $Y2 )
        $Y3 += [array]::Reverse( $Y1 )

    }elseif($ord -eq "random"){
        $Y3 = $Y1
        $Y3 += $Y2
        
        $Y3 = Get-Random $Y3 -Count $Y3.Length

    }

    addYamafuda2 $name3 $Y3
    deleteYamafuda $name1
    deleteYamafuda $name2


}


function moveYamafuda($from, $to, $ord, $count1){

    $fromAr1 = ""
    $toAr1 = ""
    for($idx = 0; $idx -lt $script:YamafudaArray.Count; $idx++){
        $arName1 = $script:YamafudaNames[$idx]

        if($arName1 -eq $from){
            $fromAr1 = $script:YamafudaArray[$idx]
        }elseif($arName1 -eq $to){
            $toAr1 = $script:YamafudaArray[$idx]
        }
    }

    if($ord -eq "normal"){
        for($idx2 = 0; $idx2 -lt $count1; $idx2++){
            $card1 = $fromAr1[0]
            $fromAr1 = $fromAr1[1..($fromAr1-1)]

            $toAr1 = @($card1) + $toAr1
        }
    }elseif($ord -eq "random"){
        for($idx3 = 0; $idx3 -lt $count1; $idx3++){
            $rnd1 = Get-Random -Minimum 0 -Maximum  ($fromAr1.Length-1)
            $card1 = $fromAr1[$rnd1]

            $fromAr1 = $fromAr1[0..$rnd1]
            $fromAr1 += $fromAr1[$rnd1..($fromAr1.Length-1)]

            $toAr1 = @($card1) + $toAr1
        }
    }
    

}


inputUserName "ユーザA" "ユーザB"


