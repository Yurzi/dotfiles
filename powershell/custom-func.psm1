
Function Get-FileHashMatched
{
  param(
    [string] $file,
    [string] $sum_file,
    [string] $algorithm
  )

  if ($algorithm.Length -eq 0)
  {
    # get check sum algoritm from sum_file suffix name
    $suffix = $(Get-Item $sum_file).Extension;
    $algorithm = $suffix.Split(".")[1];
  }

  # read check_sum from sum_file
  $check_sum = (Get-Content $sum_file).Split(" ")[0].ToUpper();

  # get file hash sum from file
  $file_sum = Get-FileHash -Algorithm $algorithm $file;
  $file_sum = $file_sum.Hash;
    
  Write-Output ($check_sum -eq $file_sum);
}

function Get-RecycleBinContent
{
  # 获取 Shell.Application COM 对象
  $shell = New-Object -ComObject Shell.Application

  # 获取回收站目录对象 (Namespace 10)
  $recycleBin = $shell.Namespace(10)

  # 初始化一个数组来存储回收站中的项目
  $items = @()

  # 遍历回收站中的所有项目
  for ($i = 0; $i -lt $recycleBin.Items().Count; $i++)
  {
    $item = $recycleBin.Items().Item($i)
    # 将项目添加到数组中
    $items += [pscustomobject]@{
      Name         = $item.Name
      Path         = $item.Path
      OriginalPath = $recycleBin.GetDetailsOf($item, 1)
      DateDeleted  = $recycleBin.GetDetailsOf($item, 2)
      Size         = $recycleBin.GetDetailsOf($item, 3)
    }
  }

  # 返回回收站内容
  return $items
}

Export-ModuleMember -Function Get-FileHashMatched;
Export-ModuleMember -Function Get-RecycleBinContent;
