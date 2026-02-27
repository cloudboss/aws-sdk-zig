const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// The template version.
pub const TemplateVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the template version.
    arn: ?[]const u8,

    /// The time that this template version was created.
    created_time: ?i64,

    /// The description of the template version.
    description: ?[]const u8,

    /// The status of the template version.
    status: ?ResourceStatus,

    /// The version number of the template version.
    version_number: ?i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .status = "Status",
        .version_number = "VersionNumber",
    };
};
