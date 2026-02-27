/// Controller node information.
pub const ControllerNodeInfo = struct {
    /// Endpoints for accessing the Controller.
    endpoints: ?[]const []const u8,

    pub const json_field_names = .{
        .endpoints = "Endpoints",
    };
};
