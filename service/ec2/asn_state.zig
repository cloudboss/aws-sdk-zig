const std = @import("std");

pub const AsnState = enum {
    deprovisioned,
    failed_deprovision,
    failed_provision,
    pending_deprovision,
    pending_provision,
    provisioned,

    pub const json_field_names = .{
        .deprovisioned = "deprovisioned",
        .failed_deprovision = "failed-deprovision",
        .failed_provision = "failed-provision",
        .pending_deprovision = "pending-deprovision",
        .pending_provision = "pending-provision",
        .provisioned = "provisioned",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .deprovisioned => "deprovisioned",
            .failed_deprovision => "failed-deprovision",
            .failed_provision => "failed-provision",
            .pending_deprovision => "pending-deprovision",
            .pending_provision => "pending-provision",
            .provisioned => "provisioned",
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
