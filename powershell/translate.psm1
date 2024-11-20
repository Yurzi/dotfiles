<#
.SYNOPSIS
    Translate text into other languages.
.DESCRIPTION
    This PowerShell script translate text into other languages.
.PARAMETER Text
    Specifies the text to translate
.PARAMETER FromLang
    Specifies the source language (English by default)
.PARAMETER ToLang
    Specifies the target language (Chinese Simplified by default)
.PARAMETER Vendor
    Specifies the api vendor (Google by default)
.EXAMPLE
    translate "Hello World" en zh-cn
.LINK
    <None>
.NOTES
    Auther: Yurzi
#>

Function Get-APIUrl {
param(
    [string] $vendor,
    [string] $from_lang,
    [string] $to_lang
);
    $api_url = $null;

    if ("google" -eq $vendor) {
        $return_type = "t"
        $api_url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=${from_lang}&tl=${to_lang}&dt=${return_type}&q="
    } else {
        throw "Bad vendor choice!"
    }

    return $api_url;
}


Function Translate {
param(
    [string] $text,
    [string] $from_lang="en",
    [string] $to_lang="zh-CN",
    [string] $vendor="google"
);

$api_url = Get-APIUrl $vendor $from_lang $to_lang;

$request_url = $api_url + $text;

$response = Invoke-WebRequest $request_url;

$response = ConvertFrom-Json $response.Content;

Write-Output $response[0][0][0];

}

Export-ModuleMember -Function Translate;
