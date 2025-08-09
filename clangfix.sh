# DO NOT RUN THIS FILE DIRECTLY, SOURCE IT AS IT NEEDS TO BE APPLIED TO CURRENT ENV

export CLANG_PATH=$PWD/prebuilts/clang/host/linux-x86/clang-r522817/bin
export PATH=$CLANG_PATH:$PATH
alias clang=$CLANG_PATH/clang
alias clang++=$CLANG_PATH/clang++
alias ld.lld=$CLANG_PATH/ld.lld
export CC=$CLANG_PATH/clang
export CXX=$CLANG_PATH/clang++
export LD=$CLANG_PATH/ld.lld

