const aws = @import("aws");

/// A structure containing information about the query plan.
pub const QueryPlanningContext = struct {
    /// The ID of the Data Catalog where the partition in question resides. If none
    /// is provided, the Amazon Web Services account ID is used by default.
    catalog_id: ?[]const u8,

    /// The database containing the table.
    database_name: []const u8,

    /// The time as of when to read the table contents. If not set, the most recent
    /// transaction commit time will be used. Cannot be specified along with
    /// `TransactionId`.
    query_as_of_time: ?i64,

    /// A map consisting of key-value pairs.
    query_parameters: ?[]const aws.map.StringMapEntry,

    /// The transaction ID at which to read the table contents. If this transaction
    /// is not committed, the read will be treated as part of that transaction and
    /// will see its writes. If this transaction has aborted, an error will be
    /// returned. If not set, defaults to the most recent committed transaction.
    /// Cannot be specified along with `QueryAsOfTime`.
    transaction_id: ?[]const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .query_as_of_time = "QueryAsOfTime",
        .query_parameters = "QueryParameters",
        .transaction_id = "TransactionId",
    };
};
