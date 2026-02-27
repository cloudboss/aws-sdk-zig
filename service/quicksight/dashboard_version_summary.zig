const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// Dashboard version summary.
pub const DashboardVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: ?[]const u8,

    /// The time that this dashboard version was created.
    created_time: ?i64,

    /// Description.
    description: ?[]const u8,

    /// Source entity ARN.
    source_entity_arn: ?[]const u8,

    /// The HTTP status of the request.
    status: ?ResourceStatus,

    /// Version number.
    version_number: ?i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .source_entity_arn = "SourceEntityArn",
        .status = "Status",
        .version_number = "VersionNumber",
    };
};
