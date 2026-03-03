const std = @import("std");

pub const ByoipCidrState = enum {
    advertised,
    deprovisioned,
    failed_deprovision,
    failed_provision,
    pending_advertising,
    pending_deprovision,
    pending_provision,
    pending_withdrawal,
    provisioned,
    provisioned_not_publicly_advertisable,

    pub const json_field_names = .{
        .advertised = "advertised",
        .deprovisioned = "deprovisioned",
        .failed_deprovision = "failed-deprovision",
        .failed_provision = "failed-provision",
        .pending_advertising = "pending-advertising",
        .pending_deprovision = "pending-deprovision",
        .pending_provision = "pending-provision",
        .pending_withdrawal = "pending-withdrawal",
        .provisioned = "provisioned",
        .provisioned_not_publicly_advertisable = "provisioned-not-publicly-advertisable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .advertised => "advertised",
            .deprovisioned => "deprovisioned",
            .failed_deprovision => "failed-deprovision",
            .failed_provision => "failed-provision",
            .pending_advertising => "pending-advertising",
            .pending_deprovision => "pending-deprovision",
            .pending_provision => "pending-provision",
            .pending_withdrawal => "pending-withdrawal",
            .provisioned => "provisioned",
            .provisioned_not_publicly_advertisable => "provisioned-not-publicly-advertisable",
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
