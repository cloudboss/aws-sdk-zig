/// Stage of the Project
pub const DataAutomationProjectStage = enum {
    development,
    live,

    pub const json_field_names = .{
        .development = "DEVELOPMENT",
        .live = "LIVE",
    };
};
