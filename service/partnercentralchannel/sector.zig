const std = @import("std");

pub const Sector = enum {
    commercial,
    government,
    government_exception,

    pub const json_field_names = .{
        .commercial = "COMMERCIAL",
        .government = "GOVERNMENT",
        .government_exception = "GOVERNMENT_EXCEPTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .commercial => "COMMERCIAL",
            .government => "GOVERNMENT",
            .government_exception => "GOVERNMENT_EXCEPTION",
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
