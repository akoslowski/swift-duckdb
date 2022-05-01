import XCTest
@testable import CDuckDB

final class CDuckDBTests: XCTestCase {
    /// See https://duckdb.org/docs/api/c/connect
    func testConnect() throws {
        var db: duckdb_database?
        var con: duckdb_connection?

        if duckdb_open(nil, &db) == DuckDBError {
            XCTFail("duckdb_open failed")
        }

        if duckdb_connect(db, &con) == DuckDBError {
            XCTFail("duckdb_connect failed")
        }

        duckdb_disconnect(&con)
        duckdb_close(&db)
    }

    /// See https://duckdb.org/docs/api/c/query
    func testQuery() throws {
        var db: duckdb_database?
        var con: duckdb_connection?
        var state: duckdb_state?

        state = duckdb_open(nil, &db)
        if (state == DuckDBError) {
            XCTFail("duckdb_open failed")
        }
        state = duckdb_connect(db, &con)
        if (state == DuckDBError) {
            XCTFail("duckdb_connect failed")
        }

        // create a table
        state = duckdb_query(con, "CREATE TABLE integers(i INTEGER, j INTEGER);", nil);
        if (state == DuckDBError) {
            XCTFail("duckdb_query CREATE TABLE failed")
        }

        // insert three rows into the table
        state = duckdb_query(con, "INSERT INTO integers VALUES (3, 4), (5, 6), (7, NULL);", nil);
        if (state == DuckDBError) {
            XCTFail("duckdb_query INSERT INTO failed")
        }

        // query rows again
        let result = UnsafeMutablePointer<duckdb_result>.allocate(capacity: 1)
        state = duckdb_query(con, "SELECT * FROM integers", result);
        if (state == DuckDBError) {
            XCTFail("duckdb_query SELECT failed")
        }

        // print the above result to CSV format using `duckdb_value_varchar`
        let row_count = duckdb_row_count(result)
        let column_count = duckdb_column_count(result)

        (0..<row_count).forEach { row in
            (0..<column_count).forEach { col in
                let str_val = duckdb_value_varchar(result, col, row)
                if col > 0 { print(",", terminator: "") }
                if let str = str_val {
                    print(String(cString: str), terminator: "")
                } else {
                    print("nil", terminator: "")
                }
                duckdb_free(str_val)
            }
            print("")
        }

        // destroy the result after we are done with it
        duckdb_destroy_result(result)
        duckdb_disconnect(&con)
        duckdb_close(&db)
    }
}
