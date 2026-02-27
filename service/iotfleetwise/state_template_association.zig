const StateTemplateUpdateStrategy = @import("state_template_update_strategy.zig").StateTemplateUpdateStrategy;

/// The state template associated with a vehicle. State templates contain state
/// properties, which are signals that belong to a signal catalog that is
/// synchronized between the Amazon Web Services IoT FleetWise Edge and the
/// Amazon Web Services Cloud.
///
/// Access to certain Amazon Web Services IoT FleetWise features is currently
/// gated. For more information, see [Amazon Web Services Region and feature
/// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
pub const StateTemplateAssociation = struct {
    /// The unique ID of the state template.
    identifier: []const u8,

    state_template_update_strategy: StateTemplateUpdateStrategy,

    pub const json_field_names = .{
        .identifier = "identifier",
        .state_template_update_strategy = "stateTemplateUpdateStrategy",
    };
};
