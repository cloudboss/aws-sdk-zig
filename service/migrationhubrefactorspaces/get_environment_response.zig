const aws = @import("aws");

const ErrorResponse = @import("error_response.zig").ErrorResponse;
const NetworkFabricType = @import("network_fabric_type.zig").NetworkFabricType;
const EnvironmentState = @import("environment_state.zig").EnvironmentState;

pub const GetEnvironmentResponse = struct {
    /// The Amazon Resource Name (ARN) of the environment.
    arn: ?[]const u8,

    /// A timestamp that indicates when the environment is created.
    created_time: ?i64,

    /// The description of the environment.
    description: ?[]const u8,

    /// The unique identifier of the environment.
    environment_id: ?[]const u8,

    /// Any error associated with the environment resource.
    @"error": ?ErrorResponse,

    /// A timestamp that indicates when the environment was last updated.
    last_updated_time: ?i64,

    /// The name of the environment.
    name: ?[]const u8,

    /// The network fabric type of the environment.
    network_fabric_type: ?NetworkFabricType,

    /// The Amazon Web Services account ID of the environment owner.
    owner_account_id: ?[]const u8,

    /// The current state of the environment.
    state: ?EnvironmentState,

    /// The tags to assign to the environment. A tag is a label that you assign to
    /// an Amazon Web Services resource. Each tag consists of a key-value pair.
    tags: ?[]const aws.map.StringMapEntry,

    /// The ID of the Transit Gateway set up by the environment, if applicable.
    transit_gateway_id: ?[]const u8,

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
