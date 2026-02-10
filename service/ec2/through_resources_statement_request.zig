const ResourceStatementRequest = @import("resource_statement_request.zig").ResourceStatementRequest;

/// Describes a through resource statement.
pub const ThroughResourcesStatementRequest = struct {
    /// The resource statement.
    resource_statement: ?ResourceStatementRequest,
};
