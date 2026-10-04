const std = @import("std");

pub const DlpProviderType = enum {
    microsoft_purview,

    pub const json_field_names = .{
        .microsoft_purview = "MICROSOFT_PURVIEW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .microsoft_purview => "MICROSOFT_PURVIEW",
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
