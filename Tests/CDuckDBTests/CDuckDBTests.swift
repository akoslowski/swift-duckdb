import XCTest
@testable import CDuckDB

final class CDuckDBTests: XCTestCase {
    func testExample() throws {
        var db: duckdb_database?
        var con: duckdb_connection?

        if duckdb_open(nil, &db) == DuckDBError {
            XCTFail("duckdb_open failed")
        }

        if duckdb_connect(db, &con) == DuckDBError {
            XCTFail("duckdb_connect failed")
        }

        duckdb_disconnect(&con);
        duckdb_close(&db);
    }
}
