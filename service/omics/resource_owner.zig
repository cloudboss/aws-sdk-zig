pub const ResourceOwner = enum {
    /// The resource owner is the calling account
    self,
    /// The resource owner is an account other than the caller
    other,

    pub const json_field_names = .{
        .self = "SELF",
        .other = "OTHER",
    };
};
