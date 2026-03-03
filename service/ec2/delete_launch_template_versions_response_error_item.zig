const ResponseError = @import("response_error.zig").ResponseError;

/// Describes a launch template version that could not be deleted.
pub const DeleteLaunchTemplateVersionsResponseErrorItem = struct {
    /// The ID of the launch template.
    launch_template_id: ?[]const u8 = null,

    /// The name of the launch template.
    launch_template_name: ?[]const u8 = null,

    /// Information about the error.
    response_error: ?ResponseError = null,

    /// The version number of the launch template.
    version_number: ?i64 = null,
};
