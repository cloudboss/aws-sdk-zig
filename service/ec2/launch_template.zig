const OperatorResponse = @import("operator_response.zig").OperatorResponse;
const Tag = @import("tag.zig").Tag;

/// Describes a launch template.
pub const LaunchTemplate = struct {
    /// The principal that created the launch template.
    created_by: ?[]const u8 = null,

    /// The time launch template was created.
    create_time: ?i64 = null,

    /// The version number of the default version of the launch template.
    default_version_number: ?i64 = null,

    /// The version number of the latest version of the launch template.
    latest_version_number: ?i64 = null,

    /// The ID of the launch template.
    launch_template_id: ?[]const u8 = null,

    /// The name of the launch template.
    launch_template_name: ?[]const u8 = null,

    /// The entity that manages the launch template.
    operator: ?OperatorResponse = null,

    /// The tags for the launch template.
    tags: ?[]const Tag = null,
};
