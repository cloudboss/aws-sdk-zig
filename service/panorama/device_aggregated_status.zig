const std = @import("std");

pub const DeviceAggregatedStatus = enum {
    @"error",
    awaiting_provisioning,
    pending,
    failed,
    deleting,
    online,
    offline,
    lease_expired,
    update_needed,
    rebooting,

    pub const json_field_names = .{
        .@"error" = "ERROR",
        .awaiting_provisioning = "AWAITING_PROVISIONING",
        .pending = "PENDING",
        .failed = "FAILED",
        .deleting = "DELETING",
        .online = "ONLINE",
        .offline = "OFFLINE",
        .lease_expired = "LEASE_EXPIRED",
        .update_needed = "UPDATE_NEEDED",
        .rebooting = "REBOOTING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .@"error" => "ERROR",
            .awaiting_provisioning => "AWAITING_PROVISIONING",
            .pending => "PENDING",
            .failed => "FAILED",
            .deleting => "DELETING",
            .online => "ONLINE",
            .offline => "OFFLINE",
            .lease_expired => "LEASE_EXPIRED",
            .update_needed => "UPDATE_NEEDED",
            .rebooting => "REBOOTING",
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
