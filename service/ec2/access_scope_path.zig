const PathStatement = @import("path_statement.zig").PathStatement;
const ThroughResourcesStatement = @import("through_resources_statement.zig").ThroughResourcesStatement;

/// Describes a path.
pub const AccessScopePath = struct {
    /// The destination.
    destination: ?PathStatement = null,

    /// The source.
    source: ?PathStatement = null,

    /// The through resources.
    through_resources: ?[]const ThroughResourcesStatement = null,
};
