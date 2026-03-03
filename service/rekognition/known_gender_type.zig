const std = @import("std");

/// A list of enum string of possible gender values that Celebrity returns.
pub const KnownGenderType = enum {
    male,
    female,
    nonbinary,
    unlisted,

    pub const json_field_names = .{
        .male = "Male",
        .female = "Female",
        .nonbinary = "Nonbinary",
        .unlisted = "Unlisted",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .male => "Male",
            .female => "Female",
            .nonbinary => "Nonbinary",
            .unlisted => "Unlisted",
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
