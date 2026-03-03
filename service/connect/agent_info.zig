const ParticipantCapabilities = @import("participant_capabilities.zig").ParticipantCapabilities;
const DeviceInfo = @import("device_info.zig").DeviceInfo;
const HierarchyGroups = @import("hierarchy_groups.zig").HierarchyGroups;
const StateTransition = @import("state_transition.zig").StateTransition;

/// Information about the agent who accepted the contact.
pub const AgentInfo = struct {
    /// The timestamp when the contact was accepted by the agent.
    accepted_by_agent_timestamp: ?i64 = null,

    /// The difference in time, in whole seconds, between
    /// `AfterContactWorkStartTimestamp` and
    /// `AfterContactWorkEndTimestamp`.
    after_contact_work_duration: ?i32 = null,

    /// The date and time when the agent ended After Contact Work for the contact,
    /// in UTC time. In cases when agent
    /// finishes doing `AfterContactWork` for chat contacts and switches their
    /// activity status to offline or
    /// equivalent without clearing the contact in CCP, discrepancies may be noticed
    /// for
    /// `AfterContactWorkEndTimestamp`.
    after_contact_work_end_timestamp: ?i64 = null,

    /// The date and time when the agent started doing After Contact Work for the
    /// contact, in UTC time.
    after_contact_work_start_timestamp: ?i64 = null,

    /// The total hold duration in seconds initiated by the agent.
    agent_initiated_hold_duration: ?i32 = null,

    /// Agent pause duration for a contact in seconds.
    agent_pause_duration_in_seconds: ?i32 = null,

    capabilities: ?ParticipantCapabilities = null,

    /// The timestamp when the contact was connected to the agent.
    connected_to_agent_timestamp: ?i64 = null,

    /// Information regarding Agent’s device.
    device_info: ?DeviceInfo = null,

    /// The agent hierarchy groups for the agent.
    hierarchy_groups: ?HierarchyGroups = null,

    /// The identifier of the agent who accepted the contact.
    id: ?[]const u8 = null,

    /// The timestamp when the agent finished previewing the contact.
    preview_end_timestamp: ?i64 = null,

    /// List of `StateTransition` for a supervisor.
    state_transitions: ?[]const StateTransition = null,

    pub const json_field_names = .{
        .accepted_by_agent_timestamp = "AcceptedByAgentTimestamp",
        .after_contact_work_duration = "AfterContactWorkDuration",
        .after_contact_work_end_timestamp = "AfterContactWorkEndTimestamp",
        .after_contact_work_start_timestamp = "AfterContactWorkStartTimestamp",
        .agent_initiated_hold_duration = "AgentInitiatedHoldDuration",
        .agent_pause_duration_in_seconds = "AgentPauseDurationInSeconds",
        .capabilities = "Capabilities",
        .connected_to_agent_timestamp = "ConnectedToAgentTimestamp",
        .device_info = "DeviceInfo",
        .hierarchy_groups = "HierarchyGroups",
        .id = "Id",
        .preview_end_timestamp = "PreviewEndTimestamp",
        .state_transitions = "StateTransitions",
    };
};
