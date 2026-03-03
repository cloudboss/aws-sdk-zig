const std = @import("std");

pub const RenewalStatus = enum {
    pending_auto_renewal,
    pending_validation,
    success,
    failed,

    pub const json_field_names = .{
        .pending_auto_renewal = "PENDING_AUTO_RENEWAL",
        .pending_validation = "PENDING_VALIDATION",
        .success = "SUCCESS",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_auto_renewal => "PENDING_AUTO_RENEWAL",
            .pending_validation => "PENDING_VALIDATION",
            .success => "SUCCESS",
            .failed => "FAILED",
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
