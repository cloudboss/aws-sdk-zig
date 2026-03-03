const std = @import("std");

pub const SubnetState = enum {
    pending,
    available,
    unavailable,
    failed,
    failed_insufficient_capacity,

    pub const json_field_names = .{
        .pending = "pending",
        .available = "available",
        .unavailable = "unavailable",
        .failed = "failed",
        .failed_insufficient_capacity = "failed-insufficient-capacity",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "pending",
            .available => "available",
            .unavailable => "unavailable",
            .failed => "failed",
            .failed_insufficient_capacity => "failed-insufficient-capacity",
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
