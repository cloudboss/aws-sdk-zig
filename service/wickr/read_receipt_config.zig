const Status = @import("status.zig").Status;

/// Configuration for read receipts at the network level, controlling whether
/// senders can see when their messages have been read.
pub const ReadReceiptConfig = struct {
    /// The read receipt status mode for the network.
    status: ?Status = null,

    pub const json_field_names = .{
        .status = "status",
    };
};
