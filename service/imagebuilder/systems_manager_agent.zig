/// Contains settings for the Systems Manager agent on your build instance.
pub const SystemsManagerAgent = struct {
    /// Controls whether the Systems Manager agent is removed from your final build
    /// image, prior to
    /// creating the new AMI. If this is set to true, then the agent is removed from
    /// the final
    /// image. If it's set to false, then the agent is left in, so that it is
    /// included in the
    /// new AMI. default value is false.
    ///
    /// The default behavior of uninstallAfterBuild is to remove the SSM Agent if it
    /// was installed by EC2 Image Builder
    uninstall_after_build: ?bool = null,

    pub const json_field_names = .{
        .uninstall_after_build = "uninstallAfterBuild",
    };
};
