/// Blueprint Stage filter
pub const BlueprintStageFilter = enum {
    development,
    live,
    all,

    pub const json_field_names = .{
        .development = "DEVELOPMENT",
        .live = "LIVE",
        .all = "ALL",
    };
};
