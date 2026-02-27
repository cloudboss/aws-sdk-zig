/// This container specifies filtering attributes related to `BITCOIN_VOUT`
/// event types
pub const VoutFilter = struct {
    /// Specifies if the transaction output is spent or unspent.
    vout_spent: bool,

    pub const json_field_names = .{
        .vout_spent = "voutSpent",
    };
};
