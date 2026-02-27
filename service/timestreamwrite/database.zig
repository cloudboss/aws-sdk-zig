/// A top-level container for a table. Databases and tables are the fundamental
/// management
/// concepts in Amazon Timestream. All tables in a database are encrypted with
/// the
/// same KMS key.
pub const Database = struct {
    /// The Amazon Resource Name that uniquely identifies this database.
    arn: ?[]const u8,

    /// The time when the database was created, calculated from the Unix epoch time.
    creation_time: ?i64,

    /// The name of the Timestream database.
    database_name: ?[]const u8,

    /// The identifier of the KMS key used to encrypt the data stored in the
    /// database.
    kms_key_id: ?[]const u8,

    /// The last time that this database was updated.
    last_updated_time: ?i64,

    /// The total number of tables found within a Timestream database.
    table_count: i64 = 0,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .database_name = "DatabaseName",
        .kms_key_id = "KmsKeyId",
        .last_updated_time = "LastUpdatedTime",
        .table_count = "TableCount",
    };
};
