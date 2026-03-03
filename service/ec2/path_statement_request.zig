const PacketHeaderStatementRequest = @import("packet_header_statement_request.zig").PacketHeaderStatementRequest;
const ResourceStatementRequest = @import("resource_statement_request.zig").ResourceStatementRequest;

/// Describes a path statement.
pub const PathStatementRequest = struct {
    /// The packet header statement.
    packet_header_statement: ?PacketHeaderStatementRequest = null,

    /// The resource statement.
    resource_statement: ?ResourceStatementRequest = null,
};
