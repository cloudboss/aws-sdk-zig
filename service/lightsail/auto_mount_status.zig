const std = @import("std");

pub const AutoMountStatus = enum {
    failed,
    pending,
    mounted,
    not_mounted,

    pub const json_field_names = .{
        .failed = "Failed",
        .pending = "Pending",
        .mounted = "Mounted",
        .not_mounted = "NotMounted",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .failed => "Failed",
            .pending => "Pending",
            .mounted => "Mounted",
            .not_mounted => "NotMounted",
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
