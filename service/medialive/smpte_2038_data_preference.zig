const std = @import("std");

/// Smpte2038 Data Preference
pub const Smpte2038DataPreference = enum {
    ignore,
    prefer,

    pub const json_field_names = .{
        .ignore = "IGNORE",
        .prefer = "PREFER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ignore => "IGNORE",
            .prefer => "PREFER",
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
