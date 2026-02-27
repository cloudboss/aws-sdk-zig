/// The registered Amazon Timestream resources that Amazon Web Services IoT
/// FleetWise edge agent software can transfer
/// your vehicle data to.
pub const TimestreamResources = struct {
    /// The name of the registered Amazon Timestream database.
    timestream_database_name: []const u8,

    /// The name of the registered Amazon Timestream database table.
    timestream_table_name: []const u8,

    pub const json_field_names = .{
        .timestream_database_name = "timestreamDatabaseName",
        .timestream_table_name = "timestreamTableName",
    };
};
