# linux specific settings

if [[ "$(uname -s)" != "Linux" ]]; then
    return 0
fi

if [[ -x "${HOME}/programs/dotnet/dotnet" ]]; then
    export DOTNET_CLI_TELEMETRY_OPTOUT=1
    export DOTNET_ROOT="${HOME}/programs/dotnet"
fi

# vim: set ft=zsh:
