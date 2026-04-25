const std = @import("std");

pub const StorageEncryptionType = enum {
    unencrypted,
    cmk,
    sse,

    pub const json_field_names = .{
        .unencrypted = "none",
        .cmk = "sse-kms",
        .sse = "sse-rds",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unencrypted => "none",
            .cmk => "sse-kms",
            .sse => "sse-rds",
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
