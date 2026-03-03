const std = @import("std");

pub const BatchGetRepositoriesErrorCodeEnum = enum {
    encryption_integrity_checks_failed_exception,
    encryption_key_access_denied_exception,
    encryption_key_disabled_exception,
    encryption_key_not_found_exception,
    encryption_key_unavailable_exception,
    repository_does_not_exist_exception,

    pub const json_field_names = .{
        .encryption_integrity_checks_failed_exception = "EncryptionIntegrityChecksFailedException",
        .encryption_key_access_denied_exception = "EncryptionKeyAccessDeniedException",
        .encryption_key_disabled_exception = "EncryptionKeyDisabledException",
        .encryption_key_not_found_exception = "EncryptionKeyNotFoundException",
        .encryption_key_unavailable_exception = "EncryptionKeyUnavailableException",
        .repository_does_not_exist_exception = "RepositoryDoesNotExistException",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .encryption_integrity_checks_failed_exception => "EncryptionIntegrityChecksFailedException",
            .encryption_key_access_denied_exception => "EncryptionKeyAccessDeniedException",
            .encryption_key_disabled_exception => "EncryptionKeyDisabledException",
            .encryption_key_not_found_exception => "EncryptionKeyNotFoundException",
            .encryption_key_unavailable_exception => "EncryptionKeyUnavailableException",
            .repository_does_not_exist_exception => "RepositoryDoesNotExistException",
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
