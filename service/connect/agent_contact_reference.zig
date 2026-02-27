const ContactState = @import("contact_state.zig").ContactState;
const Channel = @import("channel.zig").Channel;
const ContactInitiationMethod = @import("contact_initiation_method.zig").ContactInitiationMethod;
const QueueReference = @import("queue_reference.zig").QueueReference;

/// Information about the
/// [contact](https://docs.aws.amazon.com/connect/latest/APIReference/API_Contact.html) associated to the user.
pub const AgentContactReference = struct {
    /// The [state of the
    /// contact](https://docs.aws.amazon.com/connect/latest/adminguide/about-contact-states.html).
    ///
    /// When `AgentContactState` is set to `CONNECTED_ONHOLD`, `StateStartTimestamp`
    /// is not changed. Instead, `StateStartTimestamp` reflects the time the contact
    /// was `CONNECTED`
    /// to the agent.
    agent_contact_state: ?ContactState,

    /// The channel of the contact.
    channel: ?Channel,

    /// The time at which the contact was connected to an agent.
    connected_to_agent_timestamp: ?i64,

    /// The identifier of the contact in this instance of Amazon Connect.
    contact_id: ?[]const u8,

    /// How the contact was initiated.
    initiation_method: ?ContactInitiationMethod,

    queue: ?QueueReference,

    /// The epoch timestamp when the contact state started.
    state_start_timestamp: ?i64,

    pub const json_field_names = .{
        .agent_contact_state = "AgentContactState",
        .channel = "Channel",
        .connected_to_agent_timestamp = "ConnectedToAgentTimestamp",
        .contact_id = "ContactId",
        .initiation_method = "InitiationMethod",
        .queue = "Queue",
        .state_start_timestamp = "StateStartTimestamp",
    };
};
