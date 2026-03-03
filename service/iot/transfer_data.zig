/// Data used to transfer a certificate to an Amazon Web Services account.
pub const TransferData = struct {
    /// The date the transfer was accepted.
    accept_date: ?i64 = null,

    /// The date the transfer was rejected.
    reject_date: ?i64 = null,

    /// The reason why the transfer was rejected.
    reject_reason: ?[]const u8 = null,

    /// The date the transfer took place.
    transfer_date: ?i64 = null,

    /// The transfer message.
    transfer_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .accept_date = "acceptDate",
        .reject_date = "rejectDate",
        .reject_reason = "rejectReason",
        .transfer_date = "transferDate",
        .transfer_message = "transferMessage",
    };
};
