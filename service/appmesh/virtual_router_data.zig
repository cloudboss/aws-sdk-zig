const ResourceMetadata = @import("resource_metadata.zig").ResourceMetadata;
const VirtualRouterSpec = @import("virtual_router_spec.zig").VirtualRouterSpec;
const VirtualRouterStatus = @import("virtual_router_status.zig").VirtualRouterStatus;

/// An object that represents a virtual router returned by a describe operation.
pub const VirtualRouterData = struct {
    /// The name of the service mesh that the virtual router resides in.
    mesh_name: []const u8,

    /// The associated metadata for the virtual router.
    metadata: ResourceMetadata,

    /// The specifications of the virtual router.
    spec: VirtualRouterSpec,

    /// The current status of the virtual router.
    status: VirtualRouterStatus,

    /// The name of the virtual router.
    virtual_router_name: []const u8,

    pub const json_field_names = .{
        .mesh_name = "meshName",
        .metadata = "metadata",
        .spec = "spec",
        .status = "status",
        .virtual_router_name = "virtualRouterName",
    };
};
