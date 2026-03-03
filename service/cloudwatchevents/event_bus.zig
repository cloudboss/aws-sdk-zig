/// An event bus receives events from a source and routes them to rules
/// associated with that
/// event bus. Your account's default event bus receives events from Amazon Web
/// Services services. A custom event
/// bus can receive events from your custom applications and services. A partner
/// event bus
/// receives events from an event source created by an SaaS partner. These
/// events come from the
/// partners services or applications.
pub const EventBus = struct {
    /// The ARN of the event bus.
    arn: ?[]const u8 = null,

    /// The name of the event bus.
    name: ?[]const u8 = null,

    /// The permissions policy of the event bus, describing which other Amazon Web
    /// Services accounts can write
    /// events to this event bus.
    policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
        .policy = "Policy",
    };
};
