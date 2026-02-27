/// Multiplex MediaConnect output destination settings.
pub const MultiplexMediaConnectOutputDestinationSettings = struct {
    /// The MediaConnect entitlement ARN available as a Flow source.
    entitlement_arn: ?[]const u8,

    pub const json_field_names = .{
        .entitlement_arn = "EntitlementArn",
    };
};
