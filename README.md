# README

`CDuckDB` package provides access to [duckdb](https://duckdb.org) via the [C API](https://duckdb.org/docs/api/c/overview).

## Updating

- Clone or download https://github.com/duckdb/duckdb
- Run `python3 scripts/amalgamation.py --extended`
- Copy `src/amalgamation/duckdb.cpp` to `Sources/CDuckDB/`
- Copy `src/amalgamation/duckdb.hpp` to `Sources/CDuckDB/include`
- Copy `src/include/duckdb.h` to `Sources/CDuckDB/include`
