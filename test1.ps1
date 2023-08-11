Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
 
 <#
#フォーム
$form = New-Object System.Windows.Forms.Form 
$form.Text = "イメージテスト"
$form.Size = New-Object System.Drawing.Size(300,200) 
$form.StartPosition = "CenterScreen"
 
#PictureBox
$pic = New-Object System.Windows.Forms.PictureBox
$pic.Size = New-Object System.Drawing.Size(100, 100)
$pic.Image = [System.Drawing.Image]::FromFile("C:\Users\shizu\OneDrive\デスクトップ\images\a1.png")
$pic.Location = New-Object System.Drawing.Point(20,20) 
$pic.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom
$form.Controls.Add($pic) 

#PictureBox
$pic = New-Object System.Windows.Forms.PictureBox
$pic.Size = New-Object System.Drawing.Size(100, 100)
$pic.Image = [System.Drawing.Image]::FromFile("C:\Users\shizu\OneDrive\デスクトップ\images\a2.png")
$pic.Location = New-Object System.Drawing.Point(130,20) 
$pic.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom
$form.Controls.Add($pic) 

 
#フォームを表示
$result = $form.ShowDialog()
 
#リソースを開放
$pic.Image.Dispose()
$pic.Image = $null

#>

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


$U1 = @("C:\Users\shizu\OneDrive\デスクトップ\images\a1.png",
        "C:\Users\shizu\OneDrive\デスクトップ\images\a2.png",
        "C:\Users\shizu\OneDrive\デスクトップ\images\a3.png");

OutputImage $U1 @(500, 200) @(100,100)  @(20, 20)