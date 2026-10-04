/// Additional parameters specified by the acceptor while accepting the term.
pub const RenewalTermConfiguration = struct {
    /// Defines whether the acceptor has chosen to auto-renew the agreement when it
    /// reaches its end date. Can be set to `True` or `False`. The acceptor can
    /// change this value within the limits set by `LockoutPeriod` and
    /// `MaxRenewals`.
    enable_auto_renew: bool,

    pub const json_field_names = .{
        .enable_auto_renew = "enableAutoRenew",
    };
};
