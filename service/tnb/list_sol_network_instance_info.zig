const ListSolNetworkInstanceMetadata = @import("list_sol_network_instance_metadata.zig").ListSolNetworkInstanceMetadata;
const NsState = @import("ns_state.zig").NsState;

/// Info about the specific network instance.
///
/// A network instance is a single network created in Amazon Web Services TNB
/// that can be deployed and on which life-cycle operations (like terminate,
/// update, and delete) can be performed.
pub const ListSolNetworkInstanceInfo = struct {
    /// Network instance ARN.
    arn: []const u8,

    /// ID of the network instance.
    id: []const u8,

    /// The metadata of the network instance.
    metadata: ListSolNetworkInstanceMetadata,

    /// ID of the network service descriptor in the network package.
    nsd_id: []const u8,

    /// ID of the network service descriptor in the network package.
    nsd_info_id: []const u8,

    /// Human-readable description of the network instance.
    ns_instance_description: []const u8,

    /// Human-readable name of the network instance.
    ns_instance_name: []const u8,

    /// The state of the network instance.
    ns_state: NsState,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .metadata = "metadata",
        .nsd_id = "nsdId",
        .nsd_info_id = "nsdInfoId",
        .ns_instance_description = "nsInstanceDescription",
        .ns_instance_name = "nsInstanceName",
        .ns_state = "nsState",
    };
};
