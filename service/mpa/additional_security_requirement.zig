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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
