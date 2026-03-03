const std = @import("std");

pub const AdjustmentType = enum {
    change_in_capacity,
    percent_change_in_capacity,
    exact_capacity,

    pub const json_field_names = .{
        .change_in_capacity = "CHANGE_IN_CAPACITY",
        .percent_change_in_capacity = "PERCENT_CHANGE_IN_CAPACITY",
        .exact_capacity = "EXACT_CAPACITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .change_in_capacity => "CHANGE_IN_CAPACITY",
            .percent_change_in_capacity => "PERCENT_CHANGE_IN_CAPACITY",
            .exact_capacity => "EXACT_CAPACITY",
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
