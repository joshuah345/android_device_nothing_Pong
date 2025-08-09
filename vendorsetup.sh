#! /bin/bash

OUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

bail_if_fail() {
    if [[ $? -ne 0 ]]; then
    echo "---- $1 failed! ----"
    git $1 --abort 
    fi
}

if ! [[ -d "$PWD/hardware/qcom-caf/sm8450/audio/graphservices" ]]; then
echo "Cloning missing graphservices for OSS audio on sm8450...."
git clone https://github.com/LineageOS/android_vendor_qcom_opensource_audioreach-graphservices/ -b lineage-22.2-caf-sm8450 hardware/qcom-caf/sm8450/audio/graphservices
fi

echo "Applying patches to fix qcom sepolicy on android 16"
cd device/qcom/sepolicy_vndr/sm8450
if [[ "$PWD" =~ "device/qcom/sepolicy_vndr/sm8450" ]]; then
    git fetch https://github.com/Evolution-X/device_qcom_sepolicy_vndr/ refs/heads/bka-sm8450 
    git cherry-pick f67ab6eeb74e7e63f8fc33e71fa68a029b2a98cc
    bail_if_fail cherry-pick
    git fetch https://github.com/Evolution-X/device_qcom_sepolicy_vndr/ refs/heads/bka-sm8450 
    git cherry-pick b1b0cdecde61b0d033bb10876507ffb1c3fb7286
    bail_if_fail cherry-pick
    cd -
fi

if ! command -v clang | grep clang/host/linux-x86/clang-r522817/bin/clang > /dev/null; then
echo "Applying fix for inline kernel build (libgcc_so.1 error)"
source $OUR_DIR/clangfix.sh
fi


