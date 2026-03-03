/// Describes a launch template version that was successfully deleted.
pub const DeleteLaunchTemplateVersionsResponseSuccessItem = struct {
    /// The ID of the launch template.
    launch_template_id: ?[]const u8 = null,

    /// The name of the launch template.
    launch_template_name: ?[]const u8 = null,

    /// The version number of the launch template.
    version_number: ?i64 = null,
};
