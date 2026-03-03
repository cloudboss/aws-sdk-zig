const std = @import("std");

pub const ShiftType = enum {
    regular,
    overridden,

    pub const json_field_names = .{
        .regular = "REGULAR",
        .overridden = "OVERRIDDEN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .regular => "REGULAR",
            .overridden => "OVERRIDDEN",
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
