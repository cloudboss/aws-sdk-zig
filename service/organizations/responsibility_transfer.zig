const TransferParticipant = @import("transfer_participant.zig").TransferParticipant;
const ResponsibilityTransferStatus = @import("responsibility_transfer_status.zig").ResponsibilityTransferStatus;
const ResponsibilityTransferType = @import("responsibility_transfer_type.zig").ResponsibilityTransferType;

/// Contains details for a transfer. A *transfer* is the arrangement
/// between two management accounts where one account designates the other with
/// specified
/// responsibilities for their organization.
pub const ResponsibilityTransfer = struct {
    /// ID for the handshake of the transfer.
    active_handshake_id: ?[]const u8,

    /// Amazon Resource Name (ARN) for the transfer.
    arn: ?[]const u8,

    /// Timestamp when the transfer ends.
    end_timestamp: ?i64,

    /// ID for the transfer.
    id: ?[]const u8,

    /// Name assigned to the transfer.
    name: ?[]const u8,

    /// Account that allows another account external to its organization to manage
    /// the
    /// specified responsibilities for the organization.
    source: ?TransferParticipant,

    /// Timestamp when the transfer starts.
    start_timestamp: ?i64,

    /// Status for the transfer.
    status: ?ResponsibilityTransferStatus,

    /// Account that manages the specified responsibilities for another
    /// organization.
    target: ?TransferParticipant,

    /// The type of transfer. Currently, only `BILLING` is supported.
    type: ?ResponsibilityTransferType,

    pub const json_field_names = .{
        .active_handshake_id = "ActiveHandshakeId",
        .arn = "Arn",
        .end_timestamp = "EndTimestamp",
        .id = "Id",
        .name = "Name",
        .source = "Source",
        .start_timestamp = "StartTimestamp",
        .status = "Status",
        .target = "Target",
        .type = "Type",
    };
};
