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
$ export PARALLEL_TEST_PROCESSORS=4
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

#### sauce_ruby with parallel_tests

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

##### test-queue (unpatched)

By default [test-queue](https://github.com/tmm1/test-queue) runs tests by
example group so it's the same result as parallel_tests.

```
$ rspec-queue --format progress spec
Starting test-queue master (/tmp/test_queue_9461_70230273870620.sock)

==> Summary (4 workers in 60.0197s)

    [ 4]                                       0 examples, 0 failures         0 suites in 0.0076s      (pid 9467 exit 0)
    [ 3]                                       0 examples, 0 failures         0 suites in 0.0086s      (pid 9466 exit 0)
    [ 1]                                       2 examples, 0 failures         1 suites in 60.0155s      (pid 9464 exit 0)
    [ 2]                                       2 examples, 0 failures         1 suites in 60.0163s      (pid 9465 exit 0)
```

#### test-queue (patched)

[Patching test-queue](https://github.com/tmm1/test-queue/issues/25#issue-102483125) to
run each example individually improves the test time by 50%.

```
$ rspec-queue --format progress spec
Starting test-queue master (/tmp/test_queue_9586_70278316902940.sock)

==> Summary (4 workers in 30.0312s)

    [ 3]                                        1 example, 0 failures         1 suites in 30.0246s      (pid 9590 exit 0)
    [ 1]                                        1 example, 0 failures         1 suites in 30.0269s      (pid 9588 exit 0)
    [ 2]                                        1 example, 0 failures         1 suites in 30.0276s      (pid 9589 exit 0)
    [ 4]                                        1 example, 0 failures         1 suites in 30.0273s      (pid 9591 exit 0)

```

Note that test-queue does [optimal scheduling of tests](https://facebook.github.io/jest/blog/2016/03/11/javascript-unit-testing-performance.html) by keeping track of the slowest tests and running them first.
