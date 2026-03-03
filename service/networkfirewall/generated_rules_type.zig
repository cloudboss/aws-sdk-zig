const std = @import("std");

pub const GeneratedRulesType = enum {
    allowlist,
    denylist,
    rejectlist,
    alertlist,

    pub const json_field_names = .{
        .allowlist = "ALLOWLIST",
        .denylist = "DENYLIST",
        .rejectlist = "REJECTLIST",
        .alertlist = "ALERTLIST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allowlist => "ALLOWLIST",
            .denylist => "DENYLIST",
            .rejectlist => "REJECTLIST",
            .alertlist => "ALERTLIST",
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
