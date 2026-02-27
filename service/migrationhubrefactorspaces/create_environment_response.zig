const aws = @import("aws");

const NetworkFabricType = @import("network_fabric_type.zig").NetworkFabricType;
const EnvironmentState = @import("environment_state.zig").EnvironmentState;

pub const CreateEnvironmentResponse = struct {
    /// The Amazon Resource Name (ARN) of the environment.
    arn: ?[]const u8,

    /// A timestamp that indicates when the environment is created.
    created_time: ?i64,

    /// A description of the environment.
    description: ?[]const u8,

    /// The unique identifier of the environment.
    environment_id: ?[]const u8,

    /// A timestamp that indicates when the environment was last updated.
    last_updated_time: ?i64,

    /// The name of the environment.
    name: ?[]const u8,

    /// The network fabric type of the environment.
    network_fabric_type: ?NetworkFabricType,

    /// The Amazon Web Services account ID of environment owner.
    owner_account_id: ?[]const u8,

    /// The current state of the environment.
    state: ?EnvironmentState,

    /// The tags assigned to the created environment. A tag is a label that you
    /// assign to an Amazon Web Services resource. Each tag consists of a key-value
    /// pair..
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .environment_id = "EnvironmentId",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .network_fabric_type = "NetworkFabricType",
        .owner_account_id = "OwnerAccountId",
        .state = "State",
        .tags = "Tags",
    };
};
