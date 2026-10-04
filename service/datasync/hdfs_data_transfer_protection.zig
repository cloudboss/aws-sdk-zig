const std = @import("std");

pub const HdfsDataTransferProtection = enum {
    disabled,
    authentication,
    integrity,
    privacy,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .authentication = "AUTHENTICATION",
        .integrity = "INTEGRITY",
        .privacy = "PRIVACY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .authentication => "AUTHENTICATION",
            .integrity => "INTEGRITY",
            .privacy => "PRIVACY",
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
