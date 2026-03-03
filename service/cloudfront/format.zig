const std = @import("std");

pub const Format = enum {
    url_encoded,

    pub const json_field_names = .{
        .url_encoded = "URLEncoded",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .url_encoded => "URLEncoded",
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
