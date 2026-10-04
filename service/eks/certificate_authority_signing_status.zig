const std = @import("std");

pub const CertificateAuthoritySigningStatus = enum {
    not_used,
    activating,
    in_use,

    pub const json_field_names = .{
        .not_used = "NOT_USED",
        .activating = "ACTIVATING",
        .in_use = "IN_USE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_used => "NOT_USED",
            .activating => "ACTIVATING",
            .in_use => "IN_USE",
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
