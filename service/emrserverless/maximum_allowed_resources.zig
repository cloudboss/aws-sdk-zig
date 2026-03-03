/// The maximum allowed cumulative resources for an application. No new
/// resources will be created once the limit is hit.
pub const MaximumAllowedResources = struct {
    /// The maximum allowed CPU for an application.
    cpu: []const u8,

    /// The maximum allowed disk for an application.
    disk: ?[]const u8 = null,

    /// The maximum allowed resources for an application.
    memory: []const u8,

    pub const json_field_names = .{
        .cpu = "cpu",
        .disk = "disk",
        .memory = "memory",
    };
};
