const MaintenanceSchedule = @import("maintenance_schedule.zig").MaintenanceSchedule;
const MaintenanceScheduleType = @import("maintenance_schedule_type.zig").MaintenanceScheduleType;
const RouterOutputType = @import("router_output_type.zig").RouterOutputType;
const RouterOutputRoutedState = @import("router_output_routed_state.zig").RouterOutputRoutedState;
const RoutingScope = @import("routing_scope.zig").RoutingScope;
const RouterOutputState = @import("router_output_state.zig").RouterOutputState;

/// A summary of a router output, including its name, type, ARN, ID, state,
/// routed state, and other key details. This structure is used in the response
/// of the ListRouterOutputs operation.
pub const ListedRouterOutput = struct {
    /// The Amazon Resource Name (ARN) of the router output.
    arn: []const u8,

    /// The Availability Zone of the router output.
    availability_zone: []const u8,

    /// The timestamp when the router output was created.
    created_at: i64,

    /// The unique identifier of the router output.
    id: []const u8,

    /// The details of the maintenance schedule for the listed router output.
    maintenance_schedule: ?MaintenanceSchedule,

    /// The type of maintenance schedule currently associated with the listed router
    /// output.
    maintenance_schedule_type: ?MaintenanceScheduleType,

    /// The maximum bitrate of the router output.
    maximum_bitrate: i64,

    /// The number of messages associated with the router output.
    message_count: i32,

    /// The name of the router output.
    name: []const u8,

    /// The ARN of the network interface associated with the router output.
    network_interface_arn: ?[]const u8,

    /// The type of the router output.
    output_type: RouterOutputType,

    /// The AAmazon Web Services Region where the router output is located.
    region_name: []const u8,

    /// The ARN of the router input associated with the output.
    routed_input_arn: ?[]const u8,

    /// The current state of the association between the router output and its
    /// input.
    routed_state: RouterOutputRoutedState,

    /// Indicates whether the router output is configured for Regional or global
    /// routing.
    routing_scope: RoutingScope,

    /// The overall state of the router output.
    state: RouterOutputState,

    /// The timestamp when the router output was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .availability_zone = "AvailabilityZone",
        .created_at = "CreatedAt",
        .id = "Id",
        .maintenance_schedule = "MaintenanceSchedule",
        .maintenance_schedule_type = "MaintenanceScheduleType",
        .maximum_bitrate = "MaximumBitrate",
        .message_count = "MessageCount",
        .name = "Name",
        .network_interface_arn = "NetworkInterfaceArn",
        .output_type = "OutputType",
        .region_name = "RegionName",
        .routed_input_arn = "RoutedInputArn",
        .routed_state = "RoutedState",
        .routing_scope = "RoutingScope",
        .state = "State",
        .updated_at = "UpdatedAt",
    };
};
