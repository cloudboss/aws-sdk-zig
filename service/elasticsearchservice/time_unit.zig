/// Specifies the unit of a maintenance schedule duration. Valid value is HOUR.
/// See the [Developer
/// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html) for more information.
pub const TimeUnit = enum {
    hours,

    pub const json_field_names = .{
        .hours = "HOURS",
    };
};
