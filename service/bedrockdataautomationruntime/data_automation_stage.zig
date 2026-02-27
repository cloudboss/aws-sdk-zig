/// Data automation stage.
pub const DataAutomationStage = enum {
    live,
    development,

    pub const json_field_names = .{
        .live = "LIVE",
        .development = "DEVELOPMENT",
    };
};
