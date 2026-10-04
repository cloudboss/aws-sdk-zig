const std = @import("std");

/// Determines which newly created destination log groups are encrypted with the
/// configured KMS key.
pub const EncryptionScope = enum {
    /// Only destination log groups whose source log group is encrypted with a
    /// customer managed KMS key use the configured `KmsKeyArn`. This is the default
    /// behavior.
    encrypted_source_only,
    /// Every new destination log group created by this rule uses the configured
    /// `KmsKeyArn`, regardless of whether the source log group is encrypted with a
    /// customer managed key or Amazon Web Services owned encryption.
    new_destination_log_groups,

    pub const json_field_names = .{
        .encrypted_source_only = "ENCRYPTED_SOURCE_ONLY",
        .new_destination_log_groups = "NEW_DESTINATION_LOG_GROUPS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .encrypted_source_only => "ENCRYPTED_SOURCE_ONLY",
            .new_destination_log_groups => "NEW_DESTINATION_LOG_GROUPS",
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
