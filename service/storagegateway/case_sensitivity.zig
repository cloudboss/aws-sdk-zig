const std = @import("std");

pub const CaseSensitivity = enum {
    client_specified,
    case_sensitive,

    pub const json_field_names = .{
        .client_specified = "ClientSpecified",
        .case_sensitive = "CaseSensitive",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .client_specified => "ClientSpecified",
            .case_sensitive => "CaseSensitive",
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
