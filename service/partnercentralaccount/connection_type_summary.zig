const Participant = @import("participant.zig").Participant;
const ConnectionTypeStatus = @import("connection_type_status.zig").ConnectionTypeStatus;

/// Summary information about a specific connection type between partners.
pub const ConnectionTypeSummary = struct {
    /// Information about the other participant in this connection type.
    other_participant: Participant,

    /// The current status of this connection type (active, canceled, etc.).
    status: ConnectionTypeStatus,

    pub const json_field_names = .{
        .other_participant = "OtherParticipant",
        .status = "Status",
    };
};
