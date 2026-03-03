/// Specifies an Amazon DocumentDB or MongoDB data store to crawl.
pub const MongoDBTarget = struct {
    /// The name of the connection to use to connect to the Amazon DocumentDB or
    /// MongoDB target.
    connection_name: ?[]const u8 = null,

    /// The path of the Amazon DocumentDB or MongoDB target (database/collection).
    path: ?[]const u8 = null,

    /// Indicates whether to scan all the records, or to sample rows from the table.
    /// Scanning all the records can take a long time when the table is not a high
    /// throughput table.
    ///
    /// A value of `true` means to scan all records, while a value of `false` means
    /// to sample the records. If no value is specified, the value defaults to
    /// `true`.
    scan_all: ?bool = null,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .path = "Path",
        .scan_all = "ScanAll",
    };
};
