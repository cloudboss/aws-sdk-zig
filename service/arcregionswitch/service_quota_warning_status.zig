const std = @import("std");

/// The status of a service quota warning. Valid values:
///
/// `pending` - Region switch submitted a quota increase request that is still
/// open.
///
/// `denied` - The quota increase request was denied.
///
/// `insufficientPermissions` - The plan's execution role is missing a
/// permission that service quota checks require.
///
/// `maxRegionSwitchRequestsExceeded` - Region switch reached its limit on the
/// number of open quota increase requests.
///
/// `maxAccountRequestsExceeded` - The account reached the maximum number of
/// open quota increase requests.
pub const ServiceQuotaWarningStatus = enum {
    pending,
    denied,
    insufficient_permissions,
    max_region_switch_requests_exceeded,
    max_account_requests_exceeded,

    pub const json_field_names = .{
        .pending = "pending",
        .denied = "denied",
        .insufficient_permissions = "insufficientPermissions",
        .max_region_switch_requests_exceeded = "maxRegionSwitchRequestsExceeded",
        .max_account_requests_exceeded = "maxAccountRequestsExceeded",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "pending",
            .denied => "denied",
            .insufficient_permissions => "insufficientPermissions",
            .max_region_switch_requests_exceeded => "maxRegionSwitchRequestsExceeded",
            .max_account_requests_exceeded => "maxAccountRequestsExceeded",
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
