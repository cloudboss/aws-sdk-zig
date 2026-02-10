/// Indicates whether the instance is configured for hibernation. This parameter
/// is valid
/// only if the instance meets the [hibernation
/// prerequisites](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/hibernating-prerequisites.html).
pub const LaunchTemplateHibernationOptionsRequest = struct {
    /// If you set this parameter to `true`, the instance is enabled for
    /// hibernation.
    ///
    /// Default: `false`
    configured: ?bool,
};
