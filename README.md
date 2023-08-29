### **Intro** ###
#### **What** ####
This project aims to guide security researchers along the journey in squeezing out as much capability of AFL++ as possible for any engagement in which a researcher is fuzzing a target.

#### **Why** ####
It's one thing to install AFL++ and "start fuzzing."  It's quite another to install AFL++ and "fuzz effectively"


#### **How** ####
The environment project aims to:
- Avoid thashing hard drives (which is why fuzzing happens within memory for this project, i.e. the tmpfs /fuzz_session)
- Provide guidance around instrumenting binaries leveraging the __AFL_LOOP function
- Has the ability to spin up a "main" fuzzer with multiple "secondaries"
- Enabling the Creation of test cases for a given target
- Cranking out as many mutations / second as possible

#### **Installation / Usage** ####
```
$ git clone https://github.com/0dayInc/container.aflplusplus.template
$ cd container.aflplusplus.template
$ ./AFLplusplus_template.sh -h
USAGE:
./AFLplusplus_template.sh
    -h                     # Display USAGE

    -T <TARGET NAME/FLAGS> # REQUIRED
                           # TARGET NAME / FLAGS of the target binary
                           # to be fuzzed. It must reside in the
                           # TARGET prefix (i.e. /fuzz_session/TARGET)

    -m <main || secondary> # REQUIRED
                           # afl++ Mode 

    -r <src dir name>      # REQUIRED
                           # Name of the source code folder
                           # residing in ./TARGET_SRC to build

    -c                     # OPTIONAL / main MODE ONLY
                           # Nuke contents of TARGET prefix
                           # (i.e. /fuzz_session/TARGET)
                           # which is tmpfs and LOST AFTER REBOOT
                           # OF HOST OS

    -n                     # OPTIONAL / main MODE ONLY
                           # Nuke contents of multi-sync (New afl++ Session)
                           # (i.e. /fuzz_session/AFLplusplus/multi_sync)
                           # which is tmpfs and LOST AFTER REBOOT
                           # OF HOST OS

    -t                     # OPTIONAL / main MODE ONLY
                           # Nuke contents of input (afl++ Test Cases)
                           # (i.e. /fuzz_session/AFLplusplus/input)
                           # which is tmpfs and LOST AFTER REBOOT
                           # OF HOST OS

    -D                     # OPTIONAL
                           # Enable Debugging

$ cd TARGET_SRC
$ git clone <TARGET_GIT_REPO>
$ vi <TARGET_GIT_REPO>/<SRC_FILE_TO_INSTRUMENT_W __AFL_INIT && __AFL_LOOP>
```

Example Usage:
```
$ ./AFLplusplus_template.sh -r <src_folder_name> -T "target_bin --flags" -m main
```

To add another CPU core into the fuzzing mix, open a new terminal window:
```
$ ./AFLplusplus_template.sh -r <src_folder_name> -T "target_bin --flags" -m secondary
```

To add your own test cases, place them in ./TARGET/test_cases and they'll be copied into /fuzz_session/AFLplusplus/input.

Happy Fuzzing!
