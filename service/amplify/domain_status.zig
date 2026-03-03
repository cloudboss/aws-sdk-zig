const std = @import("std");

pub const DomainStatus = enum {
    pending_verification,
    in_progress,
    available,
    importing_custom_certificate,
    pending_deployment,
    awaiting_app_cname,
    failed,
    creating,
    requesting_certificate,
    updating,

    pub const json_field_names = .{
        .pending_verification = "PENDING_VERIFICATION",
        .in_progress = "IN_PROGRESS",
        .available = "AVAILABLE",
        .importing_custom_certificate = "IMPORTING_CUSTOM_CERTIFICATE",
        .pending_deployment = "PENDING_DEPLOYMENT",
        .awaiting_app_cname = "AWAITING_APP_CNAME",
        .failed = "FAILED",
        .creating = "CREATING",
        .requesting_certificate = "REQUESTING_CERTIFICATE",
        .updating = "UPDATING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_verification => "PENDING_VERIFICATION",
            .in_progress => "IN_PROGRESS",
            .available => "AVAILABLE",
            .importing_custom_certificate => "IMPORTING_CUSTOM_CERTIFICATE",
            .pending_deployment => "PENDING_DEPLOYMENT",
            .awaiting_app_cname => "AWAITING_APP_CNAME",
            .failed => "FAILED",
            .creating => "CREATING",
            .requesting_certificate => "REQUESTING_CERTIFICATE",
            .updating => "UPDATING",
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
