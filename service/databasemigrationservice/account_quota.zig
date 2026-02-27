/// Describes a quota for an Amazon Web Services account, for example the number
/// of replication instances
/// allowed.
pub const AccountQuota = struct {
    /// The name of the DMS quota for this Amazon Web Services account.
    account_quota_name: ?[]const u8,

    /// The maximum allowed value for the quota.
    max: i64 = 0,

    /// The amount currently used toward the quota maximum.
    used: i64 = 0,

    pub const json_field_names = .{
        .account_quota_name = "AccountQuotaName",
        .max = "Max",
        .used = "Used",
    };
};
