const Bridge = @import("bridge.zig").Bridge;

pub const UpdateBridgeResponse = struct {
    /// The bridge that was updated.
    bridge: ?Bridge = null,

    pub const json_field_names = .{
        .bridge = "Bridge",
    };
};
