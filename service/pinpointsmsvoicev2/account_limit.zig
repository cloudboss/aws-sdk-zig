const AccountLimitName = @import("account_limit_name.zig").AccountLimitName;

/// The current resource quotas associated with an Amazon Web Services account.
pub const AccountLimit = struct {
    /// The Amazon Web Services set limit for that resource type, in US dollars.
    max: i64 = 0,

    /// The name of the attribute to apply the account limit to.
    name: AccountLimitName,

    /// The current amount that has been spent, in US dollars.
    used: i64 = 0,

    pub const json_field_names = .{
        .max = "Max",
        .name = "Name",
        .used = "Used",
    };
};
