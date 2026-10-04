const std = @import("std");

pub const AdvancedSecurityEnabledModeType = enum {
    audit,
    enforced,

    pub const json_field_names = .{
        .audit = "AUDIT",
        .enforced = "ENFORCED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .audit => "AUDIT",
            .enforced => "ENFORCED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
