const std = @import("std");

pub const EncryptionStatus = enum {
    enabled,
    updating,
    kms_key_inaccessible,
    enabling,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .updating = "UPDATING",
        .kms_key_inaccessible = "KMS_KEY_INACCESSIBLE",
        .enabling = "ENABLING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
            .updating => "UPDATING",
            .kms_key_inaccessible => "KMS_KEY_INACCESSIBLE",
            .enabling => "ENABLING",
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
