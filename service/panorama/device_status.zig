const std = @import("std");

pub const DeviceStatus = enum {
    awaiting_provisioning,
    pending,
    succeeded,
    failed,
    @"error",
    deleting,

    pub const json_field_names = .{
        .awaiting_provisioning = "AWAITING_PROVISIONING",
        .pending = "PENDING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .@"error" = "ERROR",
        .deleting = "DELETING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .awaiting_provisioning => "AWAITING_PROVISIONING",
            .pending => "PENDING",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .@"error" => "ERROR",
            .deleting => "DELETING",
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
