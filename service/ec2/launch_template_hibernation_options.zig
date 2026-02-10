/// Indicates whether an instance is configured for hibernation.
pub const LaunchTemplateHibernationOptions = struct {
    /// If this parameter is set to `true`, the instance is enabled for
    /// hibernation; otherwise, it is not enabled for hibernation.
    configured: ?bool,
};
