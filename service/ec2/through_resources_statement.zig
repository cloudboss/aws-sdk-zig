const ResourceStatement = @import("resource_statement.zig").ResourceStatement;

/// Describes a through resource statement.
pub const ThroughResourcesStatement = struct {
    /// The resource statement.
    resource_statement: ?ResourceStatement,
};
