const std = @import("std");

pub const MissingDataTreatmentOption = enum {
    interpolate,
    show_as_zero,
    show_as_blank,

    pub const json_field_names = .{
        .interpolate = "INTERPOLATE",
        .show_as_zero = "SHOW_AS_ZERO",
        .show_as_blank = "SHOW_AS_BLANK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .interpolate => "INTERPOLATE",
            .show_as_zero => "SHOW_AS_ZERO",
            .show_as_blank => "SHOW_AS_BLANK",
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
