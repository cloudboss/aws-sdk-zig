const std = @import("std");

pub const CisTargetStatusReason = enum {
    scan_in_progress,
    unsupported_os,
    ssm_unmanaged,

    pub const json_field_names = .{
        .scan_in_progress = "SCAN_IN_PROGRESS",
        .unsupported_os = "UNSUPPORTED_OS",
        .ssm_unmanaged = "SSM_UNMANAGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scan_in_progress => "SCAN_IN_PROGRESS",
            .unsupported_os => "UNSUPPORTED_OS",
            .ssm_unmanaged => "SSM_UNMANAGED",
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
