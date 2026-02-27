const VirtualNodeStatusCode = @import("virtual_node_status_code.zig").VirtualNodeStatusCode;

/// An object that represents the current status of the virtual node.
pub const VirtualNodeStatus = struct {
    /// The current status of the virtual node.
    status: VirtualNodeStatusCode,

    pub const json_field_names = .{
        .status = "status",
    };
};
