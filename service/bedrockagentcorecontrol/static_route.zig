/// A static route to a single gateway target.
pub const StaticRoute = struct {
    /// The name of the target to route requests to.
    target_name: []const u8,

    pub const json_field_names = .{
        .target_name = "targetName",
    };
};
