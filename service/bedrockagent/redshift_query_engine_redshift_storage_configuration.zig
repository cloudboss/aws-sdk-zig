/// Contains configurations for storage in Amazon Redshift.
pub const RedshiftQueryEngineRedshiftStorageConfiguration = struct {
    /// The name of the Amazon Redshift database.
    database_name: []const u8,

    pub const json_field_names = .{
        .database_name = "databaseName",
    };
};
