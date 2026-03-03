const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Dashboard version summary.
pub const DashboardVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: ?[]const u8 = null,

    /// The time that this dashboard version was created.
    created_time: ?i64 = null,

    /// Description.
    description: ?[]const u8 = null,

    /// Source entity ARN.
    source_entity_arn: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?ResourceStatus = null,

    /// Version number.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .source_entity_arn = "SourceEntityArn",
        .status = "Status",
        .version_number = "VersionNumber",
    };
};
