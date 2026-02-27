/// Specifies how missing data points are treated when evaluating the alarm's
/// condition.
pub const CloudWatchAlarmTemplateTreatMissingData = enum {
    not_breaching,
    breaching,
    ignore,
    missing,

    pub const json_field_names = .{
        .not_breaching = "notBreaching",
        .breaching = "breaching",
        .ignore = "ignore",
        .missing = "missing",
    };
};
