/// A `Call` instance for a SIP media application.
pub const SipMediaApplicationCall = struct {
    /// The call's transaction ID.
    transaction_id: ?[]const u8,

    pub const json_field_names = .{
        .transaction_id = "TransactionId",
    };
};
