const ResourceMetadata = @import("resource_metadata.zig").ResourceMetadata;
const MeshSpec = @import("mesh_spec.zig").MeshSpec;
const MeshStatus = @import("mesh_status.zig").MeshStatus;

/// An object that represents a service mesh returned by a describe operation.
pub const MeshData = struct {
    /// The name of the service mesh.
    mesh_name: []const u8,

    /// The associated metadata for the service mesh.
    metadata: ResourceMetadata,

    /// The associated specification for the service mesh.
    spec: MeshSpec,

    /// The status of the service mesh.
    status: MeshStatus,

    pub const json_field_names = .{
        .mesh_name = "meshName",
        .metadata = "metadata",
        .spec = "spec",
        .status = "status",
    };
};
