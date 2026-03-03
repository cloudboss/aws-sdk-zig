const std = @import("std");

/// Hls Discontinuity Tags
pub const HlsDiscontinuityTags = enum {
    insert,
    never_insert,

    pub const json_field_names = .{
        .insert = "INSERT",
        .never_insert = "NEVER_INSERT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insert => "INSERT",
            .never_insert => "NEVER_INSERT",
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
