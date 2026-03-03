const MeshStatusCode = @import("mesh_status_code.zig").MeshStatusCode;

/// An object that represents the status of a service mesh.
pub const MeshStatus = struct {
    /// The current mesh status.
    status: ?MeshStatusCode = null,

    pub const json_field_names = .{
        .status = "status",
    };
};
