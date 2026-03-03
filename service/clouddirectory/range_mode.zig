const std = @import("std");

pub const RangeMode = enum {
    first,
    last,
    last_before_missing_values,
    inclusive,
    exclusive,

    pub const json_field_names = .{
        .first = "FIRST",
        .last = "LAST",
        .last_before_missing_values = "LAST_BEFORE_MISSING_VALUES",
        .inclusive = "INCLUSIVE",
        .exclusive = "EXCLUSIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .first => "FIRST",
            .last => "LAST",
            .last_before_missing_values => "LAST_BEFORE_MISSING_VALUES",
            .inclusive => "INCLUSIVE",
            .exclusive => "EXCLUSIVE",
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
