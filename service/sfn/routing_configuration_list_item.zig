/// Contains details about the routing configuration of a state machine alias.
/// In a routing
/// configuration, you define an array of objects that specify up to two state
/// machine versions.
/// You also specify the percentage of traffic to be routed to each version.
pub const RoutingConfigurationListItem = struct {
    /// The Amazon Resource Name (ARN) that identifies one or two state machine
    /// versions defined in the routing configuration.
    ///
    /// If you specify the ARN of a second version, it must belong to the same state
    /// machine as the first version.
    state_machine_version_arn: []const u8,

    /// The percentage of traffic you want to route to a state machine version. The
    /// sum of the
    /// weights in the routing configuration must be equal to 100.
    weight: i32 = 0,

    pub const json_field_names = .{
        .state_machine_version_arn = "stateMachineVersionArn",
        .weight = "weight",
    };
};
