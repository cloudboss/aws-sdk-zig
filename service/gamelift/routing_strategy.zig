const RoutingStrategyType = @import("routing_strategy_type.zig").RoutingStrategyType;

/// The routing configuration for a fleet alias.
///
/// **Related actions**
///
/// [All APIs by
/// task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
pub const RoutingStrategy = struct {
    /// A unique identifier for the fleet that the alias points to. This value is
    /// the fleet ID, not the fleet ARN.
    fleet_id: ?[]const u8 = null,

    /// The message text to be used with a terminal routing strategy.
    message: ?[]const u8 = null,

    /// The type of routing strategy for the alias.
    ///
    /// Possible routing types include the following:
    ///
    /// * **SIMPLE** - The alias resolves to one specific
    /// fleet. Use this type when routing to active fleets.
    ///
    /// * **TERMINAL** - The alias does not resolve to a
    /// fleet but instead can be used to display a message to the user. A terminal
    /// alias
    /// throws a TerminalRoutingStrategyException with the message embedded.
    @"type": ?RoutingStrategyType = null,

    pub const json_field_names = .{
        .fleet_id = "FleetId",
        .message = "Message",
        .@"type" = "Type",
    };
};
