const ResourceMetadata = @import("resource_metadata.zig").ResourceMetadata;
const VirtualNodeSpec = @import("virtual_node_spec.zig").VirtualNodeSpec;
const VirtualNodeStatus = @import("virtual_node_status.zig").VirtualNodeStatus;

/// An object that represents a virtual node returned by a describe operation.
pub const VirtualNodeData = struct {
    /// The name of the service mesh that the virtual node resides in.
    mesh_name: []const u8,

    /// The associated metadata for the virtual node.
    metadata: ResourceMetadata,

    /// The specifications of the virtual node.
    spec: VirtualNodeSpec,

    /// The current status for the virtual node.
    status: VirtualNodeStatus,

    /// The name of the virtual node.
    virtual_node_name: []const u8,

    pub const json_field_names = .{
        .mesh_name = "meshName",
        .metadata = "metadata",
        .spec = "spec",
        .status = "status",
        .virtual_node_name = "virtualNodeName",
    };
};
