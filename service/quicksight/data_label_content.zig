const std = @import("std");

pub const DataLabelContent = enum {
    value,
    percent,
    value_and_percent,

    pub const json_field_names = .{
        .value = "VALUE",
        .percent = "PERCENT",
        .value_and_percent = "VALUE_AND_PERCENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .value => "VALUE",
            .percent => "PERCENT",
            .value_and_percent => "VALUE_AND_PERCENT",
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
