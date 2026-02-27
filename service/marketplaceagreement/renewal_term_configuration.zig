/// Additional parameters specified by the acceptor while accepting the term.
pub const RenewalTermConfiguration = struct {
    /// Defines whether the acceptor has chosen to auto-renew the agreement at the
    /// end of its lifecycle. Can be set to `True` or `False`.
    enable_auto_renew: bool,

    pub const json_field_names = .{
        .enable_auto_renew = "enableAutoRenew",
    };
};
