const std = @import("std");

pub const CachePolicyHeaderBehavior = enum {
    none,
    whitelist,

    pub const json_field_names = .{
        .none = "none",
        .whitelist = "whitelist",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "none",
            .whitelist => "whitelist",
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
