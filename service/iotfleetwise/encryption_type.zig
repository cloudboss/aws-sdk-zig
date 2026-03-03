const std = @import("std");

pub const EncryptionType = enum {
    kms_based_encryption,
    fleetwise_default_encryption,

    pub const json_field_names = .{
        .kms_based_encryption = "KMS_BASED_ENCRYPTION",
        .fleetwise_default_encryption = "FLEETWISE_DEFAULT_ENCRYPTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .kms_based_encryption => "KMS_BASED_ENCRYPTION",
            .fleetwise_default_encryption => "FLEETWISE_DEFAULT_ENCRYPTION",
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
