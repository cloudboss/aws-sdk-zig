/// Describes a resource statement.
pub const ResourceStatement = struct {
    /// The resources.
    resources: ?[]const []const u8 = null,

    /// The resource types.
    resource_types: ?[]const []const u8 = null,
};
