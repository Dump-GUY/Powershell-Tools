$obj = @();$SF = [Environment+SpecialFolder];$SF.GetEnumNames() | %{$obj += [pscustomobject]@{NAME=$_;PATH=[Environment]::GetFolderPath($_);CSIDL=($SF::$_.value__).ToString()}}; $obj|Out-GridView -T "CSIDL"




