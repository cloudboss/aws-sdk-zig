/// Project Stage filter
pub const DataAutomationProjectStageFilter = enum {
    development,
    live,
    all,

    pub const json_field_names = .{
        .development = "DEVELOPMENT",
        .live = "LIVE",
        .all = "ALL",
    };
};
