const PacketHeaderStatement = @import("packet_header_statement.zig").PacketHeaderStatement;
const ResourceStatement = @import("resource_statement.zig").ResourceStatement;

/// Describes a path statement.
pub const PathStatement = struct {
    /// The packet header statement.
    packet_header_statement: ?PacketHeaderStatement,

    /// The resource statement.
    resource_statement: ?ResourceStatement,
};
