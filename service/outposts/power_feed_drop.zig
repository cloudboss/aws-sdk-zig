const std = @import("std");

pub const PowerFeedDrop = enum {
    above_rack,
    below_rack,

    pub const json_field_names = .{
        .above_rack = "ABOVE_RACK",
        .below_rack = "BELOW_RACK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .above_rack => "ABOVE_RACK",
            .below_rack => "BELOW_RACK",
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
