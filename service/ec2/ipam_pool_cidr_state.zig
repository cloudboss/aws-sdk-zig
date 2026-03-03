const std = @import("std");

pub const IpamPoolCidrState = enum {
    pending_provision,
    provisioned,
    failed_provision,
    pending_deprovision,
    deprovisioned,
    failed_deprovision,
    pending_import,
    failed_import,

    pub const json_field_names = .{
        .pending_provision = "pending-provision",
        .provisioned = "provisioned",
        .failed_provision = "failed-provision",
        .pending_deprovision = "pending-deprovision",
        .deprovisioned = "deprovisioned",
        .failed_deprovision = "failed-deprovision",
        .pending_import = "pending-import",
        .failed_import = "failed-import",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_provision => "pending-provision",
            .provisioned => "provisioned",
            .failed_provision => "failed-provision",
            .pending_deprovision => "pending-deprovision",
            .deprovisioned => "deprovisioned",
            .failed_deprovision => "failed-deprovision",
            .pending_import => "pending-import",
            .failed_import => "failed-import",
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
