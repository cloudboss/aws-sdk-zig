const std = @import("std");

pub const FindingType = enum {
    valid,
    invalid,
    not_translatable,
    allow_all,
    allow_none,
    deny_all,
    deny_none,

    pub const json_field_names = .{
        .valid = "VALID",
        .invalid = "INVALID",
        .not_translatable = "NOT_TRANSLATABLE",
        .allow_all = "ALLOW_ALL",
        .allow_none = "ALLOW_NONE",
        .deny_all = "DENY_ALL",
        .deny_none = "DENY_NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .valid => "VALID",
            .invalid => "INVALID",
            .not_translatable => "NOT_TRANSLATABLE",
            .allow_all => "ALLOW_ALL",
            .allow_none => "ALLOW_NONE",
            .deny_all => "DENY_ALL",
            .deny_none => "DENY_NONE",
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
