const Participant = @import("participant.zig").Participant;
const ConnectionTypeStatus = @import("connection_type_status.zig").ConnectionTypeStatus;

/// Detailed information about a specific connection type within a connection.
pub const ConnectionTypeDetail = struct {
    /// The timestamp when this connection type was cancelled, if applicable.
    canceled_at: ?i64,

    /// The AWS account ID of the participant who cancelled this connection type.
    canceled_by: ?[]const u8,

    /// The timestamp when this connection type was created.
    created_at: i64,

    /// The email address of the person who initiated this connection type.
    inviter_email: []const u8,

    /// The name of the person who initiated this connection type.
    inviter_name: []const u8,

    /// Information about the other participant in this connection type.
    other_participant: Participant,

    /// The current status of this connection type.
    status: ConnectionTypeStatus,

    pub const json_field_names = .{
        .canceled_at = "CanceledAt",
        .canceled_by = "CanceledBy",
        .created_at = "CreatedAt",
        .inviter_email = "InviterEmail",
        .inviter_name = "InviterName",
        .other_participant = "OtherParticipant",
        .status = "Status",
    };
};
