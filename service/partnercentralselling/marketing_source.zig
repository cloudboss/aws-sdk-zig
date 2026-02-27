pub const MarketingSource = enum {
    marketing_activity,
    none,

    pub const json_field_names = .{
        .marketing_activity = "MARKETING_ACTIVITY",
        .none = "NONE",
    };
};
