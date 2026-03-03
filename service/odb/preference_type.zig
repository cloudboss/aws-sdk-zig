const std = @import("std");

pub const PreferenceType = enum {
    no_preference,
    custom_preference,

    pub const json_field_names = .{
        .no_preference = "NO_PREFERENCE",
        .custom_preference = "CUSTOM_PREFERENCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_preference => "NO_PREFERENCE",
            .custom_preference => "CUSTOM_PREFERENCE",
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
