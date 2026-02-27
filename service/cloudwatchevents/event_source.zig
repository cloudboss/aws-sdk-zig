const EventSourceState = @import("event_source_state.zig").EventSourceState;

/// A partner event source is created by an SaaS partner. If a customer creates
/// a partner
/// event bus that matches this event source, that Amazon Web Services account
/// can receive events from the
/// partner's applications or services.
pub const EventSource = struct {
    /// The ARN of the event source.
    arn: ?[]const u8,

    /// The name of the partner that created the event source.
    created_by: ?[]const u8,

    /// The date and time the event source was created.
    creation_time: ?i64,

    /// The date and time that the event source will expire, if the Amazon Web
    /// Services account doesn't create a
    /// matching event bus for it.
    expiration_time: ?i64,

    /// The name of the event source.
    name: ?[]const u8,

    /// The state of the event source. If it is ACTIVE, you have already created a
    /// matching event
    /// bus for this event source, and that event bus is active. If it is PENDING,
    /// either you haven't
    /// yet created a matching event bus, or that event bus is deactivated. If it is
    /// DELETED, you have
    /// created a matching event bus, but the event source has since been deleted.
    state: ?EventSourceState,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .expiration_time = "ExpirationTime",
        .name = "Name",
        .state = "State",
    };
};
