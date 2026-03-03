const TimeUnit = @import("time_unit.zig").TimeUnit;

/// The duration of a maintenance schedule. For more information, see [Auto-Tune
/// for Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/auto-tune.html).
pub const Duration = struct {
    /// The unit of measurement for the duration of a maintenance schedule.
    unit: ?TimeUnit = null,

    /// Integer to specify the value of a maintenance schedule duration.
    value: ?i64 = null,

    pub const json_field_names = .{
        .unit = "Unit",
        .value = "Value",
    };
};
