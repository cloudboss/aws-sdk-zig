const EventSourceState = @import("event_source_state.zig").EventSourceState;

/// The Amazon Web Services account that a partner event source has been offered
/// to.
pub const PartnerEventSourceAccount = struct {
    /// The Amazon Web Services account ID that the partner event source was offered
    /// to.
    account: ?[]const u8 = null,

    /// The date and time the event source was created.
    creation_time: ?i64 = null,

    /// The date and time that the event source will expire, if the Amazon Web
    /// Services account
    /// doesn't create a matching event bus for it.
    expiration_time: ?i64 = null,

    /// The state of the event source. If it is ACTIVE, you have already created a
    /// matching event
    /// bus for this event source, and that event bus is active. If it is PENDING,
    /// either you haven't
    /// yet created a matching event bus, or that event bus is deactivated. If it is
    /// DELETED, you have
    /// created a matching event bus, but the event source has since been deleted.
    state: ?EventSourceState = null,

    pub const json_field_names = .{
        .account = "Account",
        .creation_time = "CreationTime",
        .expiration_time = "ExpirationTime",
        .state = "State",
    };
};
