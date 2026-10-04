const std = @import("std");

pub const Policy = enum {
    none,
    redacted_only,
    redacted_and_original,

    pub const json_field_names = .{
        .none = "None",
        .redacted_only = "RedactedOnly",
        .redacted_and_original = "RedactedAndOriginal",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "None",
            .redacted_only => "RedactedOnly",
            .redacted_and_original => "RedactedAndOriginal",
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
