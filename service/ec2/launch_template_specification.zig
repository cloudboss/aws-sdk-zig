/// Describes the launch template to use.
pub const LaunchTemplateSpecification = struct {
    /// The ID of the launch template.
    ///
    /// You must specify either the launch template ID or the
    /// launch template name, but not both.
    launch_template_id: ?[]const u8 = null,

    /// The name of the launch template.
    ///
    /// You must specify either the launch template ID or the
    /// launch template name, but not both.
    launch_template_name: ?[]const u8 = null,

    /// The launch template version number, `$Latest`, or
    /// `$Default`.
    ///
    /// A value of `$Latest` uses the latest version of the launch template.
    ///
    /// A value of `$Default` uses the default version of the launch template.
    ///
    /// Default: The default version of the launch template.
    version: ?[]const u8 = null,
};
