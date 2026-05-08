const std = @import("std");

pub const DateRangeComparison = enum {
    within,
    older_than,

    pub const json_field_names = .{
        .within = "WITHIN",
        .older_than = "OLDER_THAN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .within => "WITHIN",
            .older_than => "OLDER_THAN",
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
