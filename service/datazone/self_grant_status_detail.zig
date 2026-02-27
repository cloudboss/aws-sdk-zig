const SelfGrantStatus = @import("self_grant_status.zig").SelfGrantStatus;

/// The details for the self granting status.
pub const SelfGrantStatusDetail = struct {
    /// The name of the database used for the data source.
    database_name: []const u8,

    /// The reason for why the operation failed.
    failure_cause: ?[]const u8,

    /// The name of the schema used in the data source.
    schema_name: ?[]const u8,

    /// The self granting status of the data source.
    status: SelfGrantStatus,

    pub const json_field_names = .{
        .database_name = "databaseName",
        .failure_cause = "failureCause",
        .schema_name = "schemaName",
        .status = "status",
    };
};
