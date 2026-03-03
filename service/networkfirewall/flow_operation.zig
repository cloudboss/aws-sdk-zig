const FlowFilter = @import("flow_filter.zig").FlowFilter;

/// Contains information about a flow operation, such as related statuses,
/// unique identifiers, and all filters defined in the operation.
///
/// Flow operations let you manage the flows tracked in the flow table, also
/// known as the firewall table.
///
/// A flow is network traffic that is monitored by a firewall, either by
/// stateful or stateless rules.
/// For traffic to be considered part of a flow, it must share Destination,
/// DestinationPort, Direction, Protocol, Source, and SourcePort.
pub const FlowOperation = struct {
    /// Defines the scope a flow operation. You can use up to 20 filters to
    /// configure a single flow operation.
    flow_filters: ?[]const FlowFilter = null,

    /// The reqested `FlowOperation` ignores flows with an age (in seconds) lower
    /// than `MinimumFlowAgeInSeconds`.
    /// You provide this for start commands.
    minimum_flow_age_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .flow_filters = "FlowFilters",
        .minimum_flow_age_in_seconds = "MinimumFlowAgeInSeconds",
    };
};
