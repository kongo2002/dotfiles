if [[ -d "$HOME/Android/Sdk" ]]; then
    export ANDROID_HOME="$HOME/Android/Sdk"
    export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"
fi

if [[ -d "$HOME/programs/flutter/bin" ]]; then
    export PATH="$PATH:$HOME/programs/flutter/bin"
fi

if [[ -d "$HOME/.pub-cache/bin" ]]; then
    export PATH="$PATH:$HOME/.pub-cache/bin"
fi
