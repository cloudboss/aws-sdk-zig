const std = @import("std");

/// Encryption configuration for MediaConnect router. When using SECRETS_MANAGER
/// encryption, you must provide the ARN of the secret used to encrypt data in
/// transit. When using AUTOMATIC encryption, a service-managed secret will be
/// used instead.
pub const RouterEncryptionType = enum {
    automatic,
    secrets_manager,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .secrets_manager = "SECRETS_MANAGER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .automatic => "AUTOMATIC",
            .secrets_manager => "SECRETS_MANAGER",
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
