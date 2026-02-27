pub const ChannelAssociationOverrideOption = enum {
    /// AWS User Notification service users can associate or disassociate a Channel
    /// with a notification configuration.
    enabled,
    /// AWS User Notification service users can not associate or disassociate a
    /// Channel with a notification configuration.
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
