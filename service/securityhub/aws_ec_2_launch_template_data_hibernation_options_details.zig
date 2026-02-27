/// Specifies whether your Amazon EC2 instance is configured for hibernation.
pub const AwsEc2LaunchTemplateDataHibernationOptionsDetails = struct {
    /// If you set this parameter to `true`, the instance is enabled for
    /// hibernation.
    configured: ?bool,

    pub const json_field_names = .{
        .configured = "Configured",
    };
};
