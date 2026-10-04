/// Contains settings for the Systems Manager agent on your build instance. This
/// setting
/// applies to Linux and macOS build instances only. Requests that set it for a
/// recipe with a Windows base image are rejected.
pub const SystemsManagerAgent = struct {
    /// Specifies whether the Systems Manager agent is removed from your final build
    /// image
    /// before Image Builder creates the new AMI. If `true`, the agent is
    /// removed. If `false`, the agent is kept, so that it's
    /// included in the AMI. If you don't set this property, Image Builder removes
    /// the
    /// agent only if Image Builder installed the agent during the build. An agent
    /// that was
    /// pre-installed on the base image is kept.
    uninstall_after_build: ?bool = null,

    pub const json_field_names = .{
        .uninstall_after_build = "uninstallAfterBuild",
    };
};
