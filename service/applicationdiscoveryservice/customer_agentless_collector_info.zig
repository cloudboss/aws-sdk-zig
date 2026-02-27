/// The inventory data for installed Agentless Collector collectors.
pub const CustomerAgentlessCollectorInfo = struct {
    /// The number of active Agentless Collector collectors.
    active_agentless_collectors: i32 = 0,

    /// The number of deny-listed Agentless Collector collectors.
    deny_listed_agentless_collectors: i32 = 0,

    /// The number of healthy Agentless Collector collectors.
    healthy_agentless_collectors: i32 = 0,

    /// The number of Agentless Collector collectors with `SHUTDOWN` status.
    shutdown_agentless_collectors: i32 = 0,

    /// The total number of Agentless Collector collectors.
    total_agentless_collectors: i32 = 0,

    /// The number of unhealthy Agentless Collector collectors.
    unhealthy_agentless_collectors: i32 = 0,

    /// The number of unknown Agentless Collector collectors.
    unknown_agentless_collectors: i32 = 0,

    pub const json_field_names = .{
        .active_agentless_collectors = "activeAgentlessCollectors",
        .deny_listed_agentless_collectors = "denyListedAgentlessCollectors",
        .healthy_agentless_collectors = "healthyAgentlessCollectors",
        .shutdown_agentless_collectors = "shutdownAgentlessCollectors",
        .total_agentless_collectors = "totalAgentlessCollectors",
        .unhealthy_agentless_collectors = "unhealthyAgentlessCollectors",
        .unknown_agentless_collectors = "unknownAgentlessCollectors",
    };
};
