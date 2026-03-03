const std = @import("std");

/// The aggregation to apply to a metric, can be one of the following:
///
/// * `VOLUME` - The volume of events for this metric.
///
/// * `RATE` - The rate for this metric relative to the
/// `SEND` metric volume.
pub const MetricAggregation = enum {
    rate,
    volume,

    pub const json_field_names = .{
        .rate = "RATE",
        .volume = "VOLUME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rate => "RATE",
            .volume => "VOLUME",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
