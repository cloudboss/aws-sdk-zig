const S3Location = @import("s3_location.zig").S3Location;

/// Connection information for dataset input files stored in a database.
pub const DatabaseInputDefinition = struct {
    /// The table within the target database.
    database_table_name: ?[]const u8 = null,

    /// The Glue Connection that stores the connection information for the target
    /// database.
    glue_connection_name: []const u8,

    /// Custom SQL to run against the provided Glue connection. This SQL will be
    /// used as
    /// the input for DataBrew projects and jobs.
    query_string: ?[]const u8 = null,

    temp_directory: ?S3Location = null,

    pub const json_field_names = .{
        .database_table_name = "DatabaseTableName",
        .glue_connection_name = "GlueConnectionName",
        .query_string = "QueryString",
        .temp_directory = "TempDirectory",
    };
};
