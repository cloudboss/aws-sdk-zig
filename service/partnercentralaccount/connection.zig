const aws = @import("aws");

const ConnectionTypeDetail = @import("connection_type_detail.zig").ConnectionTypeDetail;

/// Base structure containing common connection properties.
pub const Connection = struct {
    /// The AWS Resource Name (ARN) of the connection.
    arn: []const u8,

    /// The catalog identifier that the connection belongs to.
    catalog: []const u8,

    /// The type of connection.
    connection_types: []const aws.map.MapEntry(ConnectionTypeDetail),

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
