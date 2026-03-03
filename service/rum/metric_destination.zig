const std = @import("std");

pub const MetricDestination = enum {
    cloud_watch,
    evidently,

    pub const json_field_names = .{
        .cloud_watch = "CloudWatch",
        .evidently = "Evidently",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cloud_watch => "CloudWatch",
            .evidently => "Evidently",
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
