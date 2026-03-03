const ResponseLaunchTemplateData = @import("response_launch_template_data.zig").ResponseLaunchTemplateData;
const OperatorResponse = @import("operator_response.zig").OperatorResponse;

/// Describes a launch template version.
pub const LaunchTemplateVersion = struct {
    /// The principal that created the version.
    created_by: ?[]const u8 = null,

    /// The time the version was created.
    create_time: ?i64 = null,

    /// Indicates whether the version is the default version.
    default_version: ?bool = null,

    /// Information about the launch template.
    launch_template_data: ?ResponseLaunchTemplateData = null,

    /// The ID of the launch template.
    launch_template_id: ?[]const u8 = null,

    /// The name of the launch template.
    launch_template_name: ?[]const u8 = null,

    /// The entity that manages the launch template.
    operator: ?OperatorResponse = null,

    /// The description for the version.
    version_description: ?[]const u8 = null,

    /// The version number.
    version_number: ?i64 = null,
};
