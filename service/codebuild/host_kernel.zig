const std = @import("std");

pub const HostKernel = enum {
    linux_kernel_4,
    linux_kernel_6,
    linux_kernel_latest,

    pub const json_field_names = .{
        .linux_kernel_4 = "LINUX_KERNEL_4",
        .linux_kernel_6 = "LINUX_KERNEL_6",
        .linux_kernel_latest = "LINUX_KERNEL_LATEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .linux_kernel_4 => "LINUX_KERNEL_4",
            .linux_kernel_6 => "LINUX_KERNEL_6",
            .linux_kernel_latest => "LINUX_KERNEL_LATEST",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
