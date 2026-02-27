/// Specifies whether the term of your reserved queue pricing plan is
/// automatically extended (AUTO_RENEW) or expires (EXPIRE) at the end of the
/// term.
pub const RenewalType = enum {
    auto_renew,
    expire,

    pub const json_field_names = .{
        .auto_renew = "AUTO_RENEW",
        .expire = "EXPIRE",
    };
};
