const std = @import("std");

pub const PasswordHashingAlgorithmType = enum {
    bcrypt,
    scrypt,
    argon2_id,
    pbkdf2_sha256,

    pub const json_field_names = .{
        .bcrypt = "BCRYPT",
        .scrypt = "SCRYPT",
        .argon2_id = "ARGON2ID",
        .pbkdf2_sha256 = "PBKDF2_SHA256",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bcrypt => "BCRYPT",
            .scrypt => "SCRYPT",
            .argon2_id => "ARGON2ID",
            .pbkdf2_sha256 => "PBKDF2_SHA256",
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
