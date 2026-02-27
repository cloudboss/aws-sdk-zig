pub const MonitorDimension = enum {
    service,
    linked_account,
    tag,
    cost_category,

    pub const json_field_names = .{
        .service = "SERVICE",
        .linked_account = "LINKED_ACCOUNT",
        .tag = "TAG",
        .cost_category = "COST_CATEGORY",
    };
};
