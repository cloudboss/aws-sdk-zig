const std = @import("std");

pub const IpamCidrStatus = enum {
    provisioned,
    failed_provision,
    provisioning,
    deprovisioned,
    failed_deprovision,
    deprovisioning,
    advertised,
    failed_advertise,
    advertising,
    withdrawn,
    failed_withdraw,
    withdrawing,

    pub const json_field_names = .{
        .provisioned = "provisioned",
        .failed_provision = "failed-provision",
        .provisioning = "provisioning",
        .deprovisioned = "deprovisioned",
        .failed_deprovision = "failed-deprovision",
        .deprovisioning = "deprovisioning",
        .advertised = "advertised",
        .failed_advertise = "failed-advertise",
        .advertising = "advertising",
        .withdrawn = "withdrawn",
        .failed_withdraw = "failed-withdraw",
        .withdrawing = "withdrawing",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .provisioned => "provisioned",
            .failed_provision => "failed-provision",
            .provisioning => "provisioning",
            .deprovisioned => "deprovisioned",
            .failed_deprovision => "failed-deprovision",
            .deprovisioning => "deprovisioning",
            .advertised => "advertised",
            .failed_advertise => "failed-advertise",
            .advertising => "advertising",
            .withdrawn => "withdrawn",
            .failed_withdraw => "failed-withdraw",
            .withdrawing => "withdrawing",
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
