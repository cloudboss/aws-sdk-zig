const ApplicationStatus = @import("application_status.zig").ApplicationStatus;

/// Basic details of an OpenSearch application.
pub const ApplicationSummary = struct {
    arn: ?[]const u8 = null,

    /// The timestamp when an OpenSearch application was created.
    created_at: ?i64 = null,

    /// The endpoint URL of an OpenSearch application.
    endpoint: ?[]const u8 = null,

    /// The unique identifier of an OpenSearch application.
    id: ?[]const u8 = null,

    /// The timestamp of the last update to an OpenSearch application.
    last_updated_at: ?i64 = null,

    /// The name of an OpenSearch application.
    name: ?[]const u8 = null,

    /// The current status of an OpenSearch application. Possible values:
    /// `CREATING`, `UPDATING`, `DELETING`,
    /// `FAILED`, `ACTIVE`, and `DELETED`.
    status: ?ApplicationStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .endpoint = "endpoint",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .status = "status",
    };
};
