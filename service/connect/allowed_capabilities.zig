const ParticipantCapabilities = @import("participant_capabilities.zig").ParticipantCapabilities;

/// Information about the capabilities enabled for participants of the contact.
pub const AllowedCapabilities = struct {
    /// Information about the agent's video sharing capabilities.
    agent: ?ParticipantCapabilities,

    /// Information about the customer's video sharing capabilities.
    customer: ?ParticipantCapabilities,

    pub const json_field_names = .{
        .agent = "Agent",
        .customer = "Customer",
    };
};
