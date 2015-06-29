# test parallel

Demos

 - [rspec](https://github.com/rspec/rspec)
 - [parallel_tests](https://github.com/grosser/parallel_tests)
 - [parallel_split_test](https://github.com/grosser/parallel_split_test)
 - [sauce_ruby branch with parallel_split_test](https://github.com/bootstraponline/sauce_ruby/tree/parallel_split_tests)

There are four tests (30 seconds each) in two files.

#### rspec

rspec is [painfully slow](logs/rspec.txt) and takes 2 minutes due to
serial execution.

```
$ rspec

Finished in 2 minutes 0 seconds (files took 0.20031 seconds to load)
4 examples, 0 failures
```

#### parallel_tests

parallel_tests is [twice as fast as rspec](logs/parallel_tests.txt) finishing
in 1 minute. Each file is run in a separate process. Tests run serially
within the process.

```
$ parallel_rspec spec/
4 processes for 2 specs, ~ 0 specs per process

4 examples, 0 failures

Took 61 seconds (1:01)
```

#### parallel_split_test

parallel_split_test is [twice as fast as parallel_tests](logs/parallel_split_tests.txt)
finishing in 30 seconds. Each test is run in a separate process.

```
$ export PARALLEL_SPLIT_TEST_PROCESSES=4
$ parallel_split_test spec/

Running examples in 4 processes

Summary:
1 example, 0 failures
1 example, 0 failures
1 example, 0 failures
1 example, 0 failures
Took 30.28 seconds with 4 processes
```

--

## sauce_ruby with parallel_tests

sauce_ruby default uses parallel_tests via `rake sauce:spec`

```
$ rake sauce:spec
4 processes for 4 specs, ~ 1 specs per process

8 examples, 0 failures

Took 62 seconds (1:02)
```

#### sauce_ruby branch with parallel_split_test

sauce_ruby [runs the tests](logs/sauce_split_tests.txt) on two platforms (firefox & safari) using
parallel_split_test. One instance of parallel_split_test is used per platform
to run all the tests. sauce_ruby with parallel_split_test is twice as fast as
parallel_tests (30 seconds vs 60 seconds).

```
$ rake sauce:spec
Running examples in 4 processes
Running examples in 4 processes

Took 30.54 seconds with 4 processes
Took 30.55 seconds with 4 processes

8 examples, 0 failures

Took 32 seconds
```
