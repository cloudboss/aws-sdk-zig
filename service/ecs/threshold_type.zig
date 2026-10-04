const std = @import("std");

/// Determines how the deployment circuit breaker calculates the number of task
/// failures tolerated before it triggers, based on the configured `value`.
pub const ThresholdType = enum {
    /// Amazon ECS uses the integer provided in `value` directly as the failure
    /// threshold.
    count,
    /// Amazon ECS calculates the failure threshold by multiplying `value` by the
    /// latest service desired count, then clamping the result to a minimum of `3`
    /// and a maximum of `200`. This is the default threshold type, with a default
    /// `value` of `50`.
    bounded_percent,
    /// Amazon ECS calculates the failure threshold by multiplying `value` by the
    /// latest service desired count, without applying the `3`-to-`200` bounds. Use
    /// this when the desired count is large enough that the calculated threshold
    /// should be allowed to exceed `200`.
    unbounded_percent,

    pub const json_field_names = .{
        .count = "COUNT",
        .bounded_percent = "BOUNDED_PERCENT",
        .unbounded_percent = "UNBOUNDED_PERCENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .count => "COUNT",
            .bounded_percent => "BOUNDED_PERCENT",
            .unbounded_percent => "UNBOUNDED_PERCENT",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
