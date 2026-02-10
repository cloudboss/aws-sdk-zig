/// Indicates whether your instance is configured for hibernation. This
/// parameter is valid
/// only if the instance meets the [hibernation
/// prerequisites](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/hibernating-prerequisites.html). For more information, see [Hibernate your Amazon EC2
/// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html) in the *Amazon EC2 User Guide*.
pub const HibernationOptions = struct {
    /// If `true`, your instance is enabled for hibernation; otherwise, it is not
    /// enabled for hibernation.
    configured: ?bool,
};
