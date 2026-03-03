const Channel = @import("channel.zig").Channel;

/// Contains the filter to apply when retrieving metrics.
pub const Filters = struct {
    /// A list of up to 50 agent status IDs or ARNs.
    agent_statuses: ?[]const []const u8 = null,

    /// The channel to use to filter the metrics.
    channels: ?[]const Channel = null,

    /// The queues to use to filter the metrics. You should specify at least one
    /// queue, and can specify up to 100 queues
    /// per request. The `GetCurrentMetricsData` API in particular requires a queue
    /// when you include a
    /// `Filter` in your request.
    queues: ?[]const []const u8 = null,

    /// A list of up to 100 routing profile IDs or ARNs.
    routing_profiles: ?[]const []const u8 = null,

    /// A list of expressions as a filter, in which an expression is an object of a
    /// step in a routing criteria.
    routing_step_expressions: ?[]const []const u8 = null,

    /// A list of up to 10 subtypes can be provided.
    subtypes: ?[]const []const u8 = null,

    /// A list of up to 10 validationTestTypes can be provided.
    validation_test_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .agent_statuses = "AgentStatuses",
        .channels = "Channels",
        .queues = "Queues",
        .routing_profiles = "RoutingProfiles",
        .routing_step_expressions = "RoutingStepExpressions",
        .subtypes = "Subtypes",
        .validation_test_types = "ValidationTestTypes",
    };
};
