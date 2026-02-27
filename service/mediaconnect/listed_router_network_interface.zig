const RouterNetworkInterfaceType = @import("router_network_interface_type.zig").RouterNetworkInterfaceType;
const RouterNetworkInterfaceState = @import("router_network_interface_state.zig").RouterNetworkInterfaceState;

/// A summary of a router network interface, including its name, type, ARN, ID,
/// associated input/output counts, state, and other key details. This structure
/// is used in the response of the ListRouterNetworkInterfaces operation.
pub const ListedRouterNetworkInterface = struct {
    /// The Amazon Resource Name (ARN) of the router network interface.
    arn: []const u8,

    /// The number of router inputs associated with the network interface.
    associated_input_count: i32,

    /// The number of router outputs associated with the network interface.
    associated_output_count: i32,

    /// The timestamp when the network interface was created.
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

    /// The timestamp when the router network interface was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .associated_input_count = "AssociatedInputCount",
        .associated_output_count = "AssociatedOutputCount",
        .created_at = "CreatedAt",
        .id = "Id",
        .name = "Name",
        .network_interface_type = "NetworkInterfaceType",
        .region_name = "RegionName",
        .state = "State",
        .updated_at = "UpdatedAt",
    };
};
