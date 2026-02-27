const ConnectionType = @import("connection_type.zig").ConnectionType;
const ParticipantType = @import("participant_type.zig").ParticipantType;
const InvitationStatus = @import("invitation_status.zig").InvitationStatus;

/// A summary view of a connection invitation containing key information without
/// full details.
pub const ConnectionInvitationSummary = struct {
    /// The Amazon Resource Name (ARN) of the connection invitation.
    arn: []const u8,

    /// The catalog identifier where the connection invitation exists.
    catalog: []const u8,

    /// The identifier of the connection associated with this invitation.
    connection_id: ?[]const u8,

    /// The type of connection being requested in the invitation.
    connection_type: ConnectionType,

    /// The timestamp when the connection invitation was created.
    created_at: i64,

    /// The timestamp when the connection invitation will expire.
    expires_at: ?i64,

    /// The unique identifier of the connection invitation.
    id: []const u8,

    /// The identifier of the other participant in the connection invitation.
    other_participant_identifier: []const u8,

    /// The type of participant (inviter or invitee) in the connection invitation.
    participant_type: ParticipantType,

    /// The current status of the connection invitation.
    status: InvitationStatus,

    /// The timestamp when the connection invitation was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .catalog = "Catalog",
        .connection_id = "ConnectionId",
        .connection_type = "ConnectionType",
        .created_at = "CreatedAt",
        .expires_at = "ExpiresAt",
        .id = "Id",
        .other_participant_identifier = "OtherParticipantIdentifier",
        .participant_type = "ParticipantType",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
