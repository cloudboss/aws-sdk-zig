/// An event bus receives events from a source, uses rules to evaluate them,
/// applies any
/// configured input transformation, and routes them to the appropriate
/// target(s). Your account's
/// default event bus receives events from Amazon Web Services services. A
/// custom event bus can
/// receive events from your custom applications and services. A partner event
/// bus receives events
/// from an event source created by an SaaS partner. These events come from the
/// partners services
/// or applications.
pub const EventBus = struct {
    /// The ARN of the event bus.
    arn: ?[]const u8 = null,

    /// The time the event bus was created.
    creation_time: ?i64 = null,

    /// The event bus description.
    description: ?[]const u8 = null,

    /// The time the event bus was last modified.
    last_modified_time: ?i64 = null,

    /// If the event bus was created on behalf of your account by an Amazon Web
    /// Services service,
    /// this field displays the principal name of the service that created the event
    /// bus.
    managed_by: ?[]const u8 = null,

    /// The name of the event bus.
    name: ?[]const u8 = null,

    /// The permissions policy of the event bus, describing which other Amazon Web
    /// Services
    /// accounts can write events to this event bus.
    policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .description = "Description",
        .last_modified_time = "LastModifiedTime",
        .managed_by = "ManagedBy",
        .name = "Name",
        .policy = "Policy",
    };
};
