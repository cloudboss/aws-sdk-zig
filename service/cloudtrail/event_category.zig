/// Specifies the event category for which aggregation configuration is enabled.
/// Valid value is Data.
pub const EventCategory = enum {
    insight,

    pub const json_field_names = .{
        .insight = "Insight",
    };
};
