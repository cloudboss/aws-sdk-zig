const std = @import("std");

pub const UpdateStatus = enum {
    requesting_certificate,
    pending_verification,
    importing_custom_certificate,
    pending_deployment,
    awaiting_app_cname,
    update_complete,
    update_failed,

    pub const json_field_names = .{
        .requesting_certificate = "REQUESTING_CERTIFICATE",
        .pending_verification = "PENDING_VERIFICATION",
        .importing_custom_certificate = "IMPORTING_CUSTOM_CERTIFICATE",
        .pending_deployment = "PENDING_DEPLOYMENT",
        .awaiting_app_cname = "AWAITING_APP_CNAME",
        .update_complete = "UPDATE_COMPLETE",
        .update_failed = "UPDATE_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .requesting_certificate => "REQUESTING_CERTIFICATE",
            .pending_verification => "PENDING_VERIFICATION",
            .importing_custom_certificate => "IMPORTING_CUSTOM_CERTIFICATE",
            .pending_deployment => "PENDING_DEPLOYMENT",
            .awaiting_app_cname => "AWAITING_APP_CNAME",
            .update_complete => "UPDATE_COMPLETE",
            .update_failed => "UPDATE_FAILED",
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
