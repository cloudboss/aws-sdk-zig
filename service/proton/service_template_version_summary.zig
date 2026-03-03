const TemplateVersionStatus = @import("template_version_status.zig").TemplateVersionStatus;

/// Summary data of an Proton service template version resource.
pub const ServiceTemplateVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the version of a service template.
    arn: []const u8,

    /// The time when the version of a service template was created.
    created_at: i64,

    /// A description of the version of a service template.
    description: ?[]const u8 = null,

    /// The time when the version of a service template was last modified.
    last_modified_at: i64,

    /// The latest major version that's associated with the version of a service
    /// template.
    major_version: []const u8,

    /// The minor version of a service template.
    minor_version: []const u8,

    /// The recommended minor version of the service template.
    recommended_minor_version: ?[]const u8 = null,

    /// The service template minor version status.
    status: TemplateVersionStatus,

    /// A service template minor version status message.
    status_message: ?[]const u8 = null,

    /// The name of the service template.
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
