const aws = @import("aws");

const AgentContactReference = @import("agent_contact_reference.zig").AgentContactReference;
const HierarchyPathReference = @import("hierarchy_path_reference.zig").HierarchyPathReference;
const RoutingProfileReference = @import("routing_profile_reference.zig").RoutingProfileReference;
const AgentStatusReference = @import("agent_status_reference.zig").AgentStatusReference;
const UserReference = @import("user_reference.zig").UserReference;

/// Data for a user.
pub const UserData = struct {
    /// A map of active slots by channel. The key is a channel name. The value is an
    /// integer: the number of active
    /// slots.
    active_slots_by_channel: ?[]const aws.map.MapEntry(i32),

    /// A map of available slots by channel. The key is a channel name. The value is
    /// an integer: the available number of
    /// slots.
    available_slots_by_channel: ?[]const aws.map.MapEntry(i32),

    /// A list of contact reference information.
    contacts: ?[]const AgentContactReference,

    /// Contains information about the levels of a hierarchy group assigned to a
    /// user.
    hierarchy_path: ?HierarchyPathReference,

    /// A map of maximum slots by channel. The key is a channel name. The value is
    /// an integer: the maximum number of
    /// slots. This is calculated from
    /// [MediaConcurrency](https://docs.aws.amazon.com/connect/latest/APIReference/API_MediaConcurrency.html) of the
    /// `RoutingProfile` assigned to the agent.
    max_slots_by_channel: ?[]const aws.map.MapEntry(i32),

    /// The Next status of the agent.
    next_status: ?[]const u8,

    /// Information about the routing profile that is assigned to the user.
    routing_profile: ?RoutingProfileReference,

    /// The status of the agent that they manually set in their Contact Control
    /// Panel (CCP), or that the supervisor
    /// manually changes in the real-time metrics report.
    status: ?AgentStatusReference,

    /// Information about the user for the data that is returned. It contains the
    /// `resourceId` and ARN of the
    /// user.
    user: ?UserReference,

    pub const json_field_names = .{
        .active_slots_by_channel = "ActiveSlotsByChannel",
        .available_slots_by_channel = "AvailableSlotsByChannel",
        .contacts = "Contacts",
        .hierarchy_path = "HierarchyPath",
        .max_slots_by_channel = "MaxSlotsByChannel",
        .next_status = "NextStatus",
        .routing_profile = "RoutingProfile",
        .status = "Status",
        .user = "User",
    };
};
