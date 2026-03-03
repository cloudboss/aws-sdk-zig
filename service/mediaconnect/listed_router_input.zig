const RouterInputType = @import("router_input_type.zig").RouterInputType;
const MaintenanceSchedule = @import("maintenance_schedule.zig").MaintenanceSchedule;
const MaintenanceScheduleType = @import("maintenance_schedule_type.zig").MaintenanceScheduleType;
const RoutingScope = @import("routing_scope.zig").RoutingScope;
const RouterInputState = @import("router_input_state.zig").RouterInputState;

/// A summary of a router input, including its name, type, ARN, ID, state, and
/// other key details. This structure is used in the response of the
/// ListRouterInputs operation.
pub const ListedRouterInput = struct {
    /// The Amazon Resource Name (ARN) of the router input.
    arn: []const u8,

    /// The Availability Zone of the router input.
    availability_zone: []const u8,

    /// The timestamp when the router input was created.
    created_at: i64,

    /// The unique identifier of the router input.
    id: []const u8,

    /// The type of the router input.
    input_type: RouterInputType,

    /// The details of the maintenance schedule for the listed router input.
    maintenance_schedule: ?MaintenanceSchedule = null,

    /// The type of maintenance schedule currently associated with the listed router
    /// input.
    maintenance_schedule_type: ?MaintenanceScheduleType = null,

    /// The maximum bitrate of the router input.
    maximum_bitrate: i64,

    /// The number of messages associated with the router input.
    message_count: i32,

    /// The name of the router input.
    name: []const u8,

    /// The ARN of the network interface associated with the router input.
    network_interface_arn: ?[]const u8 = null,

    /// The Amazon Web Services Region where the router input is located.
    region_name: []const u8,

    /// The number of router outputs that are associated with this router input.
    routed_outputs: i32,

    /// Indicates whether the router input is configured for Regional or global
    /// routing.
    routing_scope: RoutingScope,

    /// The overall state of the router input.
    state: RouterInputState,

    /// The timestamp when the router input was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .availability_zone = "AvailabilityZone",
        .created_at = "CreatedAt",
        .id = "Id",
        .input_type = "InputType",
        .maintenance_schedule = "MaintenanceSchedule",
        .maintenance_schedule_type = "MaintenanceScheduleType",
        .maximum_bitrate = "MaximumBitrate",
        .message_count = "MessageCount",
        .name = "Name",
        .network_interface_arn = "NetworkInterfaceArn",
        .region_name = "RegionName",
        .routed_outputs = "RoutedOutputs",
        .routing_scope = "RoutingScope",
        .state = "State",
        .updated_at = "UpdatedAt",
    };
};
