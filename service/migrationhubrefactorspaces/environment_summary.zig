const aws = @import("aws");

const ErrorResponse = @import("error_response.zig").ErrorResponse;
const NetworkFabricType = @import("network_fabric_type.zig").NetworkFabricType;
const EnvironmentState = @import("environment_state.zig").EnvironmentState;

/// The summary information for environments as a response to
/// `ListEnvironments`.
pub const EnvironmentSummary = struct {
    /// The Amazon Resource Name (ARN) of the environment.
    arn: ?[]const u8 = null,

    /// A timestamp that indicates when the environment is created.
    created_time: ?i64 = null,

    /// A description of the environment.
    description: ?[]const u8 = null,

    /// The unique identifier of the environment.
    environment_id: ?[]const u8 = null,

    /// Any error associated with the environment resource.
    @"error": ?ErrorResponse = null,

    /// A timestamp that indicates when the environment was last updated.
    last_updated_time: ?i64 = null,

    /// The name of the environment.
    name: ?[]const u8 = null,

    /// The network fabric type of the environment.
    network_fabric_type: ?NetworkFabricType = null,

    /// The Amazon Web Services account ID of the environment owner.
    owner_account_id: ?[]const u8 = null,

    /// The current state of the environment.
    state: ?EnvironmentState = null,

    /// The tags assigned to the environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the Transit Gateway set up by the environment.
    transit_gateway_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .environment_id = "EnvironmentId",
        .@"error" = "Error",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .network_fabric_type = "NetworkFabricType",
        .owner_account_id = "OwnerAccountId",
        .state = "State",
        .tags = "Tags",
        .transit_gateway_id = "TransitGatewayId",
    };
};
