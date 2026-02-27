const aws = @import("aws");

const RouterInputConfiguration = @import("router_input_configuration.zig").RouterInputConfiguration;
const RouterInputType = @import("router_input_type.zig").RouterInputType;
const MaintenanceConfiguration = @import("maintenance_configuration.zig").MaintenanceConfiguration;
const MaintenanceSchedule = @import("maintenance_schedule.zig").MaintenanceSchedule;
const MaintenanceScheduleType = @import("maintenance_schedule_type.zig").MaintenanceScheduleType;
const MaintenanceType = @import("maintenance_type.zig").MaintenanceType;
const RouterInputMessage = @import("router_input_message.zig").RouterInputMessage;
const RoutingScope = @import("routing_scope.zig").RoutingScope;
const RouterInputState = @import("router_input_state.zig").RouterInputState;
const RouterInputStreamDetails = @import("router_input_stream_details.zig").RouterInputStreamDetails;
const RouterInputTier = @import("router_input_tier.zig").RouterInputTier;
const RouterInputTransitEncryption = @import("router_input_transit_encryption.zig").RouterInputTransitEncryption;

/// A router input in AWS Elemental MediaConnect. A router input is a source of
/// media content that can be routed to one or more router outputs.
pub const RouterInput = struct {
    /// The Amazon Resource Name (ARN) of the router input.
    arn: []const u8,

    /// The Availability Zone of the router input.
    availability_zone: []const u8,

    configuration: RouterInputConfiguration,

    /// The timestamp when the router input was created.
    created_at: i64,

    /// The unique identifier of the router input.
    id: []const u8,

    /// The type of the router input.
    input_type: RouterInputType,

    /// The IP address of the router input.
    ip_address: ?[]const u8,

    /// The maintenance configuration settings applied to this router input.
    maintenance_configuration: MaintenanceConfiguration,

    /// The current maintenance schedule details for this router input.
    maintenance_schedule: ?MaintenanceSchedule,

    /// The type of maintenance schedule currently in effect for this router input.
    maintenance_schedule_type: ?MaintenanceScheduleType,

    /// The type of maintenance configuration applied to this router input.
    maintenance_type: MaintenanceType,

    /// The maximum bitrate for the router input.
    maximum_bitrate: i64,

    /// The maximum number of outputs that can be simultaneously routed to this
    /// input.
    maximum_routed_outputs: ?i32,

    /// The messages associated with the router input.
    messages: []const RouterInputMessage,

    /// The name of the router input.
    name: []const u8,

    /// The Amazon Web Services Region where the router input is located.
    region_name: []const u8,

    /// The number of router outputs associated with the router input.
    routed_outputs: i32,

    /// Indicates whether the router input is configured for Regional or global
    /// routing.
    routing_scope: RoutingScope,

    /// The current state of the router input.
    state: RouterInputState,

    stream_details: RouterInputStreamDetails,

    /// Key-value pairs that can be used to tag and organize this router input.
    tags: []const aws.map.StringMapEntry,

    /// The tier level of the router input.
    tier: RouterInputTier,

    transit_encryption: RouterInputTransitEncryption,

    /// The timestamp when the router input was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .availability_zone = "AvailabilityZone",
        .configuration = "Configuration",
        .created_at = "CreatedAt",
        .id = "Id",
        .input_type = "InputType",
        .ip_address = "IpAddress",
        .maintenance_configuration = "MaintenanceConfiguration",
        .maintenance_schedule = "MaintenanceSchedule",
        .maintenance_schedule_type = "MaintenanceScheduleType",
        .maintenance_type = "MaintenanceType",
        .maximum_bitrate = "MaximumBitrate",
        .maximum_routed_outputs = "MaximumRoutedOutputs",
        .messages = "Messages",
        .name = "Name",
        .region_name = "RegionName",
        .routed_outputs = "RoutedOutputs",
        .routing_scope = "RoutingScope",
        .state = "State",
        .stream_details = "StreamDetails",
        .tags = "Tags",
        .tier = "Tier",
        .transit_encryption = "TransitEncryption",
        .updated_at = "UpdatedAt",
    };
};
