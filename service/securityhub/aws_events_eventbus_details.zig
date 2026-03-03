/// Provides details about Amazon EventBridge event bus. An event bus is a
/// router that receives events and delivers
/// them to zero or more destinations, or targets. This can be a custom event
/// bus which you can use to receive events
/// from your custom applications and services, or it can be a partner event bus
/// which can be matched to a partner event
/// source.
pub const AwsEventsEventbusDetails = struct {
    /// The Amazon Resource Name (ARN) of the account permitted to write events to
    /// the current account.
    arn: ?[]const u8 = null,

    /// The name of the event bus.
    name: ?[]const u8 = null,

    /// The policy that enables the external account to send events to your account.
    policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
        .policy = "Policy",
    };
};
