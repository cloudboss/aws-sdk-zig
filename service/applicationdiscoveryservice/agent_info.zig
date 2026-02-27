const AgentNetworkInfo = @import("agent_network_info.zig").AgentNetworkInfo;
const AgentStatus = @import("agent_status.zig").AgentStatus;

/// Information about agents associated with the user’s Amazon Web Services
/// account.
/// Information includes agent IDs, IP addresses, media access control (MAC)
/// addresses, agent or collector status, hostname where the agent resides, and
/// agent
/// version for each agent.
pub const AgentInfo = struct {
    /// The agent or collector ID.
    agent_id: ?[]const u8,

    /// Network details about the host where the agent or collector resides.
    agent_network_info_list: ?[]const AgentNetworkInfo,

    /// Type of agent.
    agent_type: ?[]const u8,

    /// Status of the collection process for an agent.
    collection_status: ?[]const u8,

    /// The ID of the connector.
    connector_id: ?[]const u8,

    /// The health of the agent.
    health: ?AgentStatus,

    /// The name of the host where the agent or collector resides. The host can be a
    /// server or
    /// virtual machine.
    host_name: ?[]const u8,

    /// Time since agent health was reported.
    last_health_ping_time: ?[]const u8,

    /// Agent's first registration timestamp in UTC.
    registered_time: ?[]const u8,

    /// The agent or collector version.
    version: ?[]const u8,

    pub const json_field_names = .{
        .agent_id = "agentId",
        .agent_network_info_list = "agentNetworkInfoList",
        .agent_type = "agentType",
        .collection_status = "collectionStatus",
        .connector_id = "connectorId",
        .health = "health",
        .host_name = "hostName",
        .last_health_ping_time = "lastHealthPingTime",
        .registered_time = "registeredTime",
        .version = "version",
    };
};
