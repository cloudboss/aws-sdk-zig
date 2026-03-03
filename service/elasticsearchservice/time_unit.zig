const std = @import("std");

/// Specifies the unit of a maintenance schedule duration. Valid value is HOUR.
/// See the [Developer
/// Guide](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/auto-tune.html) for more information.
pub const TimeUnit = enum {
    hours,

    pub const json_field_names = .{
        .hours = "HOURS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hours => "HOURS",
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
