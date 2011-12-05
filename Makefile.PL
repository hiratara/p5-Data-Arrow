use inc::Module::Install;
name 'Data-Arrow';
all_from 'lib/Data/Arrow.pm';

# requires '';
recommends 'Data::Monad';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
