pub const ScanType = enum {
    guardduty_initiated,
    on_demand,

    pub const json_field_names = .{
        .guardduty_initiated = "GUARDDUTY_INITIATED",
        .on_demand = "ON_DEMAND",
    };
};
