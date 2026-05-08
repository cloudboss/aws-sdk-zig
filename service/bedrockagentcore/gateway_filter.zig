/// A filter to restrict which gateway target paths are included in the A/B
/// test.
pub const GatewayFilter = struct {
    /// A list of target path patterns to include in the A/B test.
    target_paths: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .target_paths = "targetPaths",
    };
};
