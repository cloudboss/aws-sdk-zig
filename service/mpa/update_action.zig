const std = @import("std");

/// Actions that can be taken when updating an approval team
///
/// * `SYNCHRONIZE_MFA_DEVICES`: Synchronize MFA devices for all approvers on
///   the team
pub const UpdateAction = enum {
    synchronize_mfa_devices,

    pub const json_field_names = .{
        .synchronize_mfa_devices = "SYNCHRONIZE_MFA_DEVICES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .synchronize_mfa_devices => "SYNCHRONIZE_MFA_DEVICES",
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
