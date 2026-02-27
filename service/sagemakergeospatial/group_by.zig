pub const GroupBy = enum {
    /// ALL
    all,
    /// YEARLY
    yearly,

    pub const json_field_names = .{
        .all = "ALL",
        .yearly = "YEARLY",
    };
};
