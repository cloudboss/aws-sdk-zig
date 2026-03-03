/// Specifies an Amazon Redshift data store.
pub const RedshiftSource = struct {
    /// The database to read from.
    database: []const u8,

    /// The name of the Amazon Redshift data store.
    name: []const u8,

    /// The Amazon S3 path where temporary data can be staged when copying out of
    /// the database.
    redshift_tmp_dir: ?[]const u8 = null,

    /// The database table to read from.
    table: []const u8,

    /// The IAM role with permissions.
    tmp_dir_iam_role: ?[]const u8 = null,

    pub const json_field_names = .{
        .database = "Database",
        .name = "Name",
        .redshift_tmp_dir = "RedshiftTmpDir",
        .table = "Table",
        .tmp_dir_iam_role = "TmpDirIAMRole",
    };
};
