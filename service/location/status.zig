pub const Status = enum {
    /// List all active API keys.
    active,
    /// List all expired API keys.
    expired,

    pub const json_field_names = .{
        .active = "Active",
        .expired = "Expired",
    };
};
