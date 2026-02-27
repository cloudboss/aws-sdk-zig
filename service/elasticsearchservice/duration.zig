const TimeUnit = @import("time_unit.zig").TimeUnit;

/// Specifies maintenance schedule duration: duration value and duration unit.
/// See the [Developer
/// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html) for more information.
pub const Duration = struct {
    /// Specifies the unit of a maintenance schedule duration. Valid value is HOURS.
    /// See the [Developer
    /// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html) for more information.
    unit: ?TimeUnit,

    /// Integer to specify the value of a maintenance schedule duration. See the
    /// [Developer
    /// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html) for more information.
    value: ?i64,

    pub const json_field_names = .{
        .unit = "Unit",
        .value = "Value",
    };
};
