/// Indicates whether your instance is configured for hibernation. This
/// parameter is valid
/// only if the instance meets the [hibernation
/// prerequisites](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/hibernating-prerequisites.html). For more information, see [Hibernate your Amazon EC2
/// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html) in the *Amazon EC2 User Guide*.
pub const HibernationOptionsRequest = struct {
    /// Set to `true` to enable your instance for hibernation.
    ///
    /// For Spot Instances, if you set `Configured` to `true`, either
    /// omit the `InstanceInterruptionBehavior` parameter (for [
    /// `SpotMarketOptions`
    /// ](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_SpotMarketOptions.html)), or set it to
    /// `hibernate`. When `Configured` is true:
    ///
    /// * If you omit `InstanceInterruptionBehavior`, it defaults to
    /// `hibernate`.
    ///
    /// * If you set `InstanceInterruptionBehavior` to a value other than
    /// `hibernate`, you'll get an error.
    ///
    /// Default: `false`
    configured: ?bool,
};
