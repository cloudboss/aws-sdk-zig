const TemplateVersionStatus = @import("template_version_status.zig").TemplateVersionStatus;

/// A summary of the version of an environment template detail data.
pub const EnvironmentTemplateVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the version of an environment template.
    arn: []const u8,

    /// The time when the version of an environment template was created.
    created_at: i64,

    /// A description of the version of an environment template.
    description: ?[]const u8 = null,

    /// The time when the version of an environment template was last modified.
    last_modified_at: i64,

    /// The latest major version that's associated with the version of an
    /// environment template.
    major_version: []const u8,

    /// The version of an environment template.
    minor_version: []const u8,

    /// The recommended minor version of the environment template.
    recommended_minor_version: ?[]const u8 = null,

    /// The status of the version of an environment template.
    status: TemplateVersionStatus,

    /// The status message of the version of an environment template.
    status_message: ?[]const u8 = null,

    /// The name of the environment template.
    template_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .last_modified_at = "lastModifiedAt",
        .major_version = "majorVersion",
        .minor_version = "minorVersion",
        .recommended_minor_version = "recommendedMinorVersion",
        .status = "status",
        .status_message = "statusMessage",
        .template_name = "templateName",
    };
};
