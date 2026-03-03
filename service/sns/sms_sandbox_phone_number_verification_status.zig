const std = @import("std");

/// Enum listing out all supported destination phone number verification
/// statuses. The following enum values are
/// supported.
/// 1. PENDING : The destination phone number is pending verification.
/// 2. VERIFIED : The destination phone number is verified.
pub const SMSSandboxPhoneNumberVerificationStatus = enum {
    pending,
    verified,

    pub const json_field_names = .{
        .pending = "Pending",
        .verified = "Verified",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .verified => "Verified",
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
