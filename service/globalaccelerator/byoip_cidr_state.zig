const std = @import("std");

pub const ByoipCidrState = enum {
    pending_provisioning,
    ready,
    pending_advertising,
    advertising,
    pending_withdrawing,
    pending_deprovisioning,
    deprovisioned,
    failed_provision,
    failed_advertising,
    failed_withdraw,
    failed_deprovision,

    pub const json_field_names = .{
        .pending_provisioning = "PENDING_PROVISIONING",
        .ready = "READY",
        .pending_advertising = "PENDING_ADVERTISING",
        .advertising = "ADVERTISING",
        .pending_withdrawing = "PENDING_WITHDRAWING",
        .pending_deprovisioning = "PENDING_DEPROVISIONING",
        .deprovisioned = "DEPROVISIONED",
        .failed_provision = "FAILED_PROVISION",
        .failed_advertising = "FAILED_ADVERTISING",
        .failed_withdraw = "FAILED_WITHDRAW",
        .failed_deprovision = "FAILED_DEPROVISION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_provisioning => "PENDING_PROVISIONING",
            .ready => "READY",
            .pending_advertising => "PENDING_ADVERTISING",
            .advertising => "ADVERTISING",
            .pending_withdrawing => "PENDING_WITHDRAWING",
            .pending_deprovisioning => "PENDING_DEPROVISIONING",
            .deprovisioned => "DEPROVISIONED",
            .failed_provision => "FAILED_PROVISION",
            .failed_advertising => "FAILED_ADVERTISING",
            .failed_withdraw => "FAILED_WITHDRAW",
            .failed_deprovision => "FAILED_DEPROVISION",
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
