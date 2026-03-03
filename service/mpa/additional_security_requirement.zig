const std = @import("std");

/// Additional security requirements applied to a session or invitation
///
/// * `APPROVER_VERIFICATION_REQUIRED`: Approvers will be required to perform an
///   MFA challenge to vote
pub const AdditionalSecurityRequirement = enum {
    approver_verification_required,

    pub const json_field_names = .{
        .approver_verification_required = "APPROVER_VERIFICATION_REQUIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .approver_verification_required => "APPROVER_VERIFICATION_REQUIRED",
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
