const std = @import("std");

pub const entityStatusCode = enum {
    impaired,
    unimpaired,
    unknown,
    pending,
    resolved,

    pub const json_field_names = .{
        .impaired = "IMPAIRED",
        .unimpaired = "UNIMPAIRED",
        .unknown = "UNKNOWN",
        .pending = "PENDING",
        .resolved = "RESOLVED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .impaired => "IMPAIRED",
            .unimpaired => "UNIMPAIRED",
            .unknown => "UNKNOWN",
            .pending => "PENDING",
            .resolved => "RESOLVED",
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
