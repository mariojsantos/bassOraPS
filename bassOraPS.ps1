#Powershell script to web content scanner/Directory brute force
#
<# 
 *   This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *
#> 
# The try/catch part was taken from https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.1
#
param($url,$file)

$arc = Get-childitem -Path "$file"
$lines = Get-Content -Path "$arc"
if (!$url -or !$file){
	echo "Use: .\bassOraPS.ps1 <url> <listfile>"
}else{
	
		foreach ($dir in $lines) 
		{
			
			try 
			{	
				$Response = Invoke-WebRequest -Uri "$url/$dir/" -ErrorAction Stop 
				# This will only execute if the Invoke-WebRequest is successful.				
				$StatusCode = $Response.StatusCode
			} catch
				{
					$StatusCode = $_.Exception.Response.StatusCode.value__
				}	
		
				echo "/$dir : $StatusCode" >> output.txt	
		
		}
	
      }


