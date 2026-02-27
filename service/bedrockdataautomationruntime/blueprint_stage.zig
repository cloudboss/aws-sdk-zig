/// Blueprint stage enum.
pub const BlueprintStage = enum {
    development,
    live,

    pub const json_field_names = .{
        .development = "DEVELOPMENT",
        .live = "LIVE",
    };
};
