const OnChangeStateTemplateUpdateStrategy = @import("on_change_state_template_update_strategy.zig").OnChangeStateTemplateUpdateStrategy;
const PeriodicStateTemplateUpdateStrategy = @import("periodic_state_template_update_strategy.zig").PeriodicStateTemplateUpdateStrategy;

/// The update strategy for the state template. Vehicles associated with the
/// state template can stream telemetry data with either an `onChange` or
/// `periodic` update strategy.
///
/// Access to certain Amazon Web Services IoT FleetWise features is currently
/// gated. For more information, see [Amazon Web Services Region and feature
/// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
pub const StateTemplateUpdateStrategy = union(enum) {
    on_change: ?OnChangeStateTemplateUpdateStrategy,
    periodic: ?PeriodicStateTemplateUpdateStrategy,

    pub const json_field_names = .{
        .on_change = "onChange",
        .periodic = "periodic",
    };
};
