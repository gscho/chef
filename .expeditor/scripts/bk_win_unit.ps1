$CurrentDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$PrepScript = Join-Path $CurrentDirectory "bk_win_prep.ps1"
Invoke-Expression $PrepScript

echo "+++ bundle exec rake (chef-client)"
bundle exec rake spec:unit
if (-not $?) { throw "Chef unit tests failing." }
bundle exec rake component_specs
if (-not $?) { throw "Chef component specs failing." }
cd knife
echo "+++ bundle exec rake (knife)"
bundle exec rake spec:unit
if (-not $?) { throw "Knife unit tests failing." }
