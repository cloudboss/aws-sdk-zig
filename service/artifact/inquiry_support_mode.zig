const std = @import("std");

pub const InquirySupportMode = enum {
    ai_only,
    full_support,

    pub const json_field_names = .{
        .ai_only = "AI_ONLY",
        .full_support = "FULL_SUPPORT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ai_only => "AI_ONLY",
            .full_support => "FULL_SUPPORT",
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
