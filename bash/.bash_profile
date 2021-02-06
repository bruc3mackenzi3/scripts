# Bash prompt
export PS1='\[\e[0;34m\][\u \W]$ \[\e[0m\]'

osx_profile() {
    # Silence "default interactive shell is now zsh" warning
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # Enable git auto-completion - https://apple.stackexchange.com/a/336997
    [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ] && . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
}

go_profile() {
    # For convenience
    export GOPATH=$(go env GOPATH)
    export GOROOT=$(go env GOROOT)
    export GOPRIVATE="github.com/kohofinancial"
    export GO111MODULE=on  # for enabling Go Modules on older Go versions

    # For multiple go versions
    #export PATH="$PATH:$GOPATH/bin"
    #alias 'go=go<version>'
}

koho_profile() {
    # Koho API stuff
    # For fixing Docker when it's in a bad state
    alias d_nuke='docker kill $(docker ps -q); docker container prune -f && docker rmi -f $(docker images -qa) && docker volume prune -f && docker network prune -f'
    alias d_logs='docker logs -n 10 -f koho_accounts-api_1 | jq .msg'

    # Print available AWS Role Profiles
    alias 'aws_profiles=egrep "^\[.+\]$" ~/.aws/config | awk -F"[\\\\[\\\\]]" "{print \$2}" | awk -F" " "{print \$NF}"'
    alias 'ap=aws_profiles'
    alias 'aap=aws_assume_profile'
}

function aws_assume_profile() {
    # https://github.com/kohofinancial/tools/blob/master/functions/aws_assume_profile.bash
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN

    PROFILE=$1
    if [[ $PROFILE == "" ]]
    then
        echo -n "profile? "
        read -r PROFILE
    fi

    ROLE=$( aws configure get role_arn --profile "$PROFILE" )
    if [[ $ROLE == "" ]]
    then
        echo "unable to find role_arn for $PROFILE"
        return 1
    fi

    MFA_SERIAL=$( aws configure get mfa_serial --profile "$PROFILE" )
    if [[ $MFA_SERIAL == "" ]]
    then
        echo "unable to find mfa_serial for $PROFILE"
        return 1
    fi

    MFA_CODE=$2
    if [[ $MFA_CODE == "" ]]
    then
        echo -n "mfa code for $MFA_SERIAL? "
        read -r MFA_CODE
    fi

    AWS_RESPONSE="$(
        aws sts assume-role \
            --role-arn "$ROLE" \
            --role-session-name "$PROFILE" \
            --query 'Credentials.[AccessKeyId, SecretAccessKey, SessionToken]' \
            --output text \
            --serial-number "$MFA_SERIAL" \
            --token-code "$MFA_CODE"
    )"

    IFS=$'\t' read -ra AWS_CREDENTIALS <<< "$AWS_RESPONSE"
    if [[ "${#AWS_CREDENTIALS[@]}" != 3 ]]
    then
        echo "failed to get/parse temporary aws credentials"
        return 1
    fi

    EXPORT_ARGS=(
        "AWS_ACCESS_KEY_ID=${AWS_CREDENTIALS[0]}"
        "AWS_SECRET_ACCESS_KEY=${AWS_CREDENTIALS[1]}"
        "AWS_SESSION_TOKEN=${AWS_CREDENTIALS[2]}"
    )
    if ! export "${EXPORT_ARGS[@]}"
    then
        echo "failed to export arguments"
        echo "${EXPORT_ARGS[@]}"
        return 1
    fi

    echo "role $PROFILE assumed"
    return 0
}

osx_profile
go_profile
koho_profile

# Project-specific environments
#currentProject="helloworld"
if [ "$currentProject" == "helloworld" ]
then
    cd $GOPATH/src/github.com/bruce-koho/helloworldservice
fi
