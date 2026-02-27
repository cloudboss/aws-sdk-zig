const aws = @import("aws");

const ConnectionTypeSummary = @import("connection_type_summary.zig").ConnectionTypeSummary;

/// A summary view of an active connection between partners containing key
/// information.
pub const ConnectionSummary = struct {
    /// The Amazon Resource Name (ARN) of the connection.
    arn: []const u8,

    /// The catalog identifier where the connection exists.
    catalog: []const u8,

    /// A map of connection types and their summary information for this connection.
    connection_types: []const aws.map.MapEntry(ConnectionTypeSummary),

    /// The unique identifier of the connection.
    id: []const u8,

    /// The AWS account ID of the other participant in the connection.
    other_participant_account_id: []const u8,

    /// The timestamp when the connection was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .connection_types = "ConnectionTypes",
        .id = "Id",
        .other_participant_account_id = "OtherParticipantAccountId",
        .updated_at = "UpdatedAt",
    };
};
