const aws = @import("aws");

const NetworkFabricType = @import("network_fabric_type.zig").NetworkFabricType;

pub const CreateEnvironmentRequest = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request.
    client_token: ?[]const u8 = null,

    /// The description of the environment.
    description: ?[]const u8 = null,

    /// The name of the environment.
    name: []const u8,

    /// The network fabric type of the environment.
    network_fabric_type: NetworkFabricType,

    /// The tags to assign to the environment. A tag is a label that you assign to
    /// an Amazon Web Services resource. Each tag consists of a key-value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .name = "Name",
        .network_fabric_type = "NetworkFabricType",
        .tags = "Tags",
    };
};
