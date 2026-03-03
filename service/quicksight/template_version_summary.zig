const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// The template version.
pub const TemplateVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the template version.
    arn: ?[]const u8 = null,

    /// The time that this template version was created.
    created_time: ?i64 = null,

    /// The description of the template version.
    description: ?[]const u8 = null,

    /// The status of the template version.
    status: ?ResourceStatus = null,

    /// The version number of the template version.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .status = "Status",
        .version_number = "VersionNumber",
    };
};
