const ResponseError = @import("response_error.zig").ResponseError;

/// Describes a launch template version that could not be deleted.
pub const DeleteLaunchTemplateVersionsResponseErrorItem = struct {
    /// The ID of the launch template.
    launch_template_id: ?[]const u8,

    /// The name of the launch template.
    launch_template_name: ?[]const u8,

    /// Information about the error.
    response_error: ?ResponseError,

    /// The version number of the launch template.
    version_number: ?i64,
};
