const PathStatementRequest = @import("path_statement_request.zig").PathStatementRequest;
const ThroughResourcesStatementRequest = @import("through_resources_statement_request.zig").ThroughResourcesStatementRequest;

/// Describes a path.
pub const AccessScopePathRequest = struct {
    /// The destination.
    destination: ?PathStatementRequest = null,

    /// The source.
    source: ?PathStatementRequest = null,

    /// The through resources.
    through_resources: ?[]const ThroughResourcesStatementRequest = null,
};
