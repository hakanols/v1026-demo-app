FROM arm32v7/ubuntu:18.04

RUN apt-get update
RUN apt-get install -y curl llvm-dev libclang-dev clang git cmake pkg-config libunwind-dev golang vim

RUN curl -Lq https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2 | tar xjf - -C ~
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s - '-y'

RUN bash -c 'source $HOME/.cargo/env; rustup install nightly'
RUN bash -c "source $HOME/.cargo/env; rustup target add thumbv8m.main-none-eabi"

RUN echo "export PATH=${PATH}:~/gcc-arm-none-eabi-8-2018-q4-major/bin:~/.cargo/bin" >> $HOME/.bashrc
RUN echo "export NEWLIB_PATH=~/gcc-arm-none-eabi-8-2018-q4-major/arm-none-eabi/include" >> $HOME/.bashrc

RUN bash -c "source $HOME/.cargo/env; cargo +nightly install bindgen"

WORKDIR /src
