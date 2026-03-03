const std = @import("std");

pub const VisualRole = enum {
    primary,
    complimentary,
    multi_intent,
    fallback,
    fragment,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .complimentary = "COMPLIMENTARY",
        .multi_intent = "MULTI_INTENT",
        .fallback = "FALLBACK",
        .fragment = "FRAGMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .primary => "PRIMARY",
            .complimentary => "COMPLIMENTARY",
            .multi_intent => "MULTI_INTENT",
            .fallback => "FALLBACK",
            .fragment => "FRAGMENT",
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
