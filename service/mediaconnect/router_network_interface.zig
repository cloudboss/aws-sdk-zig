const aws = @import("aws");

const RouterNetworkInterfaceConfiguration = @import("router_network_interface_configuration.zig").RouterNetworkInterfaceConfiguration;
const RouterNetworkInterfaceType = @import("router_network_interface_type.zig").RouterNetworkInterfaceType;
const RouterNetworkInterfaceState = @import("router_network_interface_state.zig").RouterNetworkInterfaceState;

/// A router network interface in AWS Elemental MediaConnect. A router network
/// interface is a network interface that can be associated with one or more
/// router inputs and outputs.
pub const RouterNetworkInterface = struct {
    /// The Amazon Resource Name (ARN) of the router network interface.
    arn: []const u8,

    /// The number of router inputs associated with the network interface.
    associated_input_count: i32,

    /// The number of router outputs associated with the network interface.
    associated_output_count: i32,

    configuration: RouterNetworkInterfaceConfiguration,

    /// The timestamp when the router network interface was created.
    created_at: i64,

    /// The unique identifier of the router network interface.
    id: []const u8,

    /// The name of the router network interface.
    name: []const u8,

    /// The type of the router network interface.
    network_interface_type: RouterNetworkInterfaceType,

    /// The Amazon Web Services Region where the router network interface is
    /// located.
    region_name: []const u8,

    /// The current state of the router network interface.
    state: RouterNetworkInterfaceState,

    /// Key-value pairs that can be used to tag and organize this router network
    /// interface.
    tags: []const aws.map.StringMapEntry,

    /// The timestamp when the router network interface was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .associated_input_count = "AssociatedInputCount",
        .associated_output_count = "AssociatedOutputCount",
        .configuration = "Configuration",
        .created_at = "CreatedAt",
        .id = "Id",
        .name = "Name",
        .network_interface_type = "NetworkInterfaceType",
        .region_name = "RegionName",
        .state = "State",
        .tags = "Tags",
        .updated_at = "UpdatedAt",
    };
};
