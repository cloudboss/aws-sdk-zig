const std = @import("std");

pub const IdentityProviderAuthenticationMode = enum {
    identity_provider_only,
    identity_provider_and_directory,

    pub const json_field_names = .{
        .identity_provider_only = "IDENTITY_PROVIDER_ONLY",
        .identity_provider_and_directory = "IDENTITY_PROVIDER_AND_DIRECTORY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .identity_provider_only => "IDENTITY_PROVIDER_ONLY",
            .identity_provider_and_directory => "IDENTITY_PROVIDER_AND_DIRECTORY",
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
