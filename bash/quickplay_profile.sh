_print_debug "Entering quickplay_profile.sh ..."

_PATH_SUFFIX="\
:/usr/local/sonar-scanner-4.7.0.2747-macosx/bin\
:/opt/homebrew/Cellar/libcouchbase/3.3.2/bin\
:/Users/brucem/Applications/google-cloud-sdk/bin"
export PATH=$PATH$_PATH_SUFFIX

if [ -z "$GOPRIVATE" ]
then
    _OLD_GOPRIVATE="$GOPRIVATE,"
fi
export GOPRIVATE="${_OLD_GOPRIVATE}\
github.com/fl-g6,\
github.com/fl-vod,\
github.com/fl-vod-gcp,\
github.com/fl-media,\
github.com/fl-media-gcp,\
github.com/fl-edge-service,\
github.com/pldt-edge,\
github.com/pldt-cms,\
github.com/univ-edge"

_print_debug "... exiting quickplay_profile.sh"
