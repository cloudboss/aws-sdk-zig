const std = @import("std");

pub const EncryptionType = enum {
    sitewise_default_encryption,
    kms_based_encryption,

    pub const json_field_names = .{
        .sitewise_default_encryption = "SITEWISE_DEFAULT_ENCRYPTION",
        .kms_based_encryption = "KMS_BASED_ENCRYPTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sitewise_default_encryption => "SITEWISE_DEFAULT_ENCRYPTION",
            .kms_based_encryption => "KMS_BASED_ENCRYPTION",
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
