const std = @import("std");

pub const EvaluationFrequency = enum {
    one_min,
    five_min,
    ten_min,
    fifteen_min,
    thirty_min,
    one_hour,

    pub const json_field_names = .{
        .one_min = "ONE_MIN",
        .five_min = "FIVE_MIN",
        .ten_min = "TEN_MIN",
        .fifteen_min = "FIFTEEN_MIN",
        .thirty_min = "THIRTY_MIN",
        .one_hour = "ONE_HOUR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .one_min => "ONE_MIN",
            .five_min => "FIVE_MIN",
            .ten_min => "TEN_MIN",
            .fifteen_min => "FIFTEEN_MIN",
            .thirty_min => "THIRTY_MIN",
            .one_hour => "ONE_HOUR",
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
