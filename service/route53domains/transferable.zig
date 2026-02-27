/// Whether the domain name can be transferred to Route 53.
///
/// You can transfer only domains that have a value of `TRANSFERABLE` or
/// `Transferable`.
///
/// Valid values:
///
/// **TRANSFERABLE**
///
/// The domain name can be transferred to Route 53.
///
/// **UNTRANSFERRABLE**
///
/// The domain name can't be transferred to Route 53.
///
/// **DONT_KNOW**
///
/// Reserved for future use.
///
/// **DOMAIN_IN_OWN_ACCOUNT**
///
/// The domain already exists in the current Amazon Web Services account.
///
/// **DOMAIN_IN_ANOTHER_ACCOUNT**
///
/// The domain exists in another Amazon Web Services account.
///
/// **PREMIUM_DOMAIN**
///
/// Premium domain transfer is not supported.
pub const Transferable = enum {
    transferable,
    untransferable,
    dont_know,
    domain_in_own_account,
    domain_in_another_account,
    premium_domain,

    pub const json_field_names = .{
        .transferable = "TRANSFERABLE",
        .untransferable = "UNTRANSFERABLE",
        .dont_know = "DONT_KNOW",
        .domain_in_own_account = "DOMAIN_IN_OWN_ACCOUNT",
        .domain_in_another_account = "DOMAIN_IN_ANOTHER_ACCOUNT",
        .premium_domain = "PREMIUM_DOMAIN",
    };
};
