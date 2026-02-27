const ResourceMetadata = @import("resource_metadata.zig").ResourceMetadata;
const VirtualServiceSpec = @import("virtual_service_spec.zig").VirtualServiceSpec;
const VirtualServiceStatus = @import("virtual_service_status.zig").VirtualServiceStatus;

/// An object that represents a virtual service returned by a describe
/// operation.
pub const VirtualServiceData = struct {
    /// The name of the service mesh that the virtual service resides in.
    mesh_name: []const u8,

    metadata: ResourceMetadata,

    /// The specifications of the virtual service.
    spec: VirtualServiceSpec,

    /// The current status of the virtual service.
    status: VirtualServiceStatus,

    /// The name of the virtual service.
    virtual_service_name: []const u8,

    pub const json_field_names = .{
        .mesh_name = "meshName",
        .metadata = "metadata",
        .spec = "spec",
        .status = "status",
        .virtual_service_name = "virtualServiceName",
    };
};
