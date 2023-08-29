# #!/bin/bash --login
target_repo="${1}"

other_repos_root='/opt'
docker_repo_root="${other_repos_root}/container.aflplusplus.template"

fuzz_session_root='/fuzz_session'
afl_session_root="${fuzz_session_root}/AFLplusplus"
afl_input="${afl_session_root}/input"
afl_output="${afl_session_root}/multi_sync"

target_prefix="${docker_repo_root}/TARGET"

# Define Target Instrumentation via instrumentation_globals.sh
source $docker_repo_root/TARGET/instrumentation_globals.sh

bash --login -c "
  echo 'Welcome to the AFL++ Container...';
  echo 'Press CTRL+D Twice to Build the Instrumented Target';
  /bin/bash
"
# THIS IS AN EXAMPLE OF HOW TO BUILD A TARGET FOLLOWING INSTRUMENTATION
export LD=/usr/bin/ld
cd $target_repo && CC=$preferred_afl CXX=$preferred_aflplusplus RANLIB=$preferred_afl_ranlib AR=$preferred_afl_ar NM=$preferred_alf_nm make clean
cd $target_repo && CC=$preferred_afl CXX=$preferred_aflplusplus RANLIB=$preferred_afl_ranlib AR=$preferred_afl_ar NM=$preferred_alf_nm ./buildconf --force
cd ${target_repo} && CC=$preferred_afl CXX=$preferred_aflplusplus RANLIB=$preferred_afl_ranlib AR=$preferred_afl_ar NM=$preferred_afl_nm ./configure
cd ${target_repo} && CC=$preferred_afl CXX=$preferred_aflplusplus RANLIB=$preferred_afl_ranlib AR=$preferred_afl_ar NM=$preferred_afl_nm make
cd ${target_repo} && make install

echo 'Fuzzing will begin in 10 seconds'
for i in {1..10}; do
  printf '.'
  sleep 1
done
