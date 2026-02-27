const aws = @import("aws");

const RouterOutputConfiguration = @import("router_output_configuration.zig").RouterOutputConfiguration;
const MaintenanceConfiguration = @import("maintenance_configuration.zig").MaintenanceConfiguration;
const MaintenanceSchedule = @import("maintenance_schedule.zig").MaintenanceSchedule;
const MaintenanceScheduleType = @import("maintenance_schedule_type.zig").MaintenanceScheduleType;
const MaintenanceType = @import("maintenance_type.zig").MaintenanceType;
const RouterOutputMessage = @import("router_output_message.zig").RouterOutputMessage;
const RouterOutputType = @import("router_output_type.zig").RouterOutputType;
const RouterOutputRoutedState = @import("router_output_routed_state.zig").RouterOutputRoutedState;
const RoutingScope = @import("routing_scope.zig").RoutingScope;
const RouterOutputState = @import("router_output_state.zig").RouterOutputState;
const RouterOutputStreamDetails = @import("router_output_stream_details.zig").RouterOutputStreamDetails;
const RouterOutputTier = @import("router_output_tier.zig").RouterOutputTier;

/// A router output in AWS Elemental MediaConnect. A router output is a
/// destination for media content that can receive input from one or more router
/// inputs.
pub const RouterOutput = struct {
    /// The Amazon Resource Name (ARN) of the router output.
    arn: []const u8,

    /// The Availability Zone of the router output.
    availability_zone: []const u8,

    configuration: RouterOutputConfiguration,

    /// The timestamp when the router output was created.
    created_at: i64,

    /// The unique identifier of the router output.
    id: []const u8,

    /// The IP address of the router output.
    ip_address: ?[]const u8,

    /// The maintenance configuration settings applied to this router output.
    maintenance_configuration: MaintenanceConfiguration,

    /// The current maintenance schedule details for this router output.
    maintenance_schedule: ?MaintenanceSchedule,

    /// The type of maintenance schedule currently in effect for this router output.
    maintenance_schedule_type: ?MaintenanceScheduleType,

    /// The type of maintenance configuration applied to this router output.
    maintenance_type: MaintenanceType,

    /// The maximum bitrate for the router output.
    maximum_bitrate: i64,

    /// The messages associated with the router output.
    messages: []const RouterOutputMessage,

    /// The name of the router output.
    name: []const u8,

    /// The type of the router output.
    output_type: RouterOutputType,

    /// The Amazon Web Services Region where the router output is located.
    region_name: []const u8,

    /// The Amazon Resource Name (ARN) of the router input associated with the
    /// output.
    routed_input_arn: ?[]const u8,

    /// The current state of the association between the router output and its
    /// input.
    routed_state: RouterOutputRoutedState,

    /// Indicates whether the router output is configured for Regional or global
    /// routing.
    routing_scope: RoutingScope,

    /// The overall state of the router output.
    state: RouterOutputState,

    stream_details: RouterOutputStreamDetails,

    /// Key-value pairs that can be used to tag and organize this router output.
    tags: []const aws.map.StringMapEntry,

    /// The tier level of the router output.
    tier: RouterOutputTier,

    /// The timestamp when the router output was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .availability_zone = "AvailabilityZone",
        .configuration = "Configuration",
        .created_at = "CreatedAt",
        .id = "Id",
        .ip_address = "IpAddress",
        .maintenance_configuration = "MaintenanceConfiguration",
        .maintenance_schedule = "MaintenanceSchedule",
        .maintenance_schedule_type = "MaintenanceScheduleType",
        .maintenance_type = "MaintenanceType",
        .maximum_bitrate = "MaximumBitrate",
        .messages = "Messages",
        .name = "Name",
        .output_type = "OutputType",
        .region_name = "RegionName",
        .routed_input_arn = "RoutedInputArn",
        .routed_state = "RoutedState",
        .routing_scope = "RoutingScope",
        .state = "State",
        .stream_details = "StreamDetails",
        .tags = "Tags",
        .tier = "Tier",
        .updated_at = "UpdatedAt",
    };
};
