const std = @import("std");

/// The lifecycle status of an Amazon Web Services Identity and Access
/// Management (IAM) service role used for Autonomous Database integration with
/// Oracle Cloud Infrastructure (OCI).
pub const OciIamRoleStatus = enum {
    provisioning,
    available,
    provision_failed,
    terminating,
    terminate_failed,

    pub const json_field_names = .{
        .provisioning = "PROVISIONING",
        .available = "AVAILABLE",
        .provision_failed = "PROVISION_FAILED",
        .terminating = "TERMINATING",
        .terminate_failed = "TERMINATE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .provisioning => "PROVISIONING",
            .available => "AVAILABLE",
            .provision_failed => "PROVISION_FAILED",
            .terminating => "TERMINATING",
            .terminate_failed => "TERMINATE_FAILED",
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
