const UpsertRedshiftTargetOptions = @import("upsert_redshift_target_options.zig").UpsertRedshiftTargetOptions;

/// Specifies a target that uses Amazon Redshift.
pub const RedshiftTarget = struct {
    /// The name of the database to write to.
    database: []const u8,

    /// The nodes that are inputs to the data target.
    inputs: []const []const u8,

    /// The name of the data target.
    name: []const u8,

    /// The Amazon S3 path where temporary data can be staged when copying out of
    /// the database.
    redshift_tmp_dir: ?[]const u8,

    /// The name of the table in the database to write to.
    table: []const u8,

    /// The IAM role with permissions.
    tmp_dir_iam_role: ?[]const u8,

    /// The set of options to configure an upsert operation when writing to a
    /// Redshift target.
    upsert_redshift_options: ?UpsertRedshiftTargetOptions,

    pub const json_field_names = .{
        .database = "Database",
        .inputs = "Inputs",
        .name = "Name",
        .redshift_tmp_dir = "RedshiftTmpDir",
        .table = "Table",
        .tmp_dir_iam_role = "TmpDirIAMRole",
        .upsert_redshift_options = "UpsertRedshiftOptions",
    };
};
