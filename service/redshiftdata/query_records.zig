/// The results of the SQL statement.
pub const QueryRecords = union(enum) {
    /// The results of the SQL statement in CSV format.
    csv_records: ?[]const u8,

    pub const json_field_names = .{
        .csv_records = "CSVRecords",
    };
};
