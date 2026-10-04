const std = @import("std");

pub const DiskState = enum {
    pending,
    @"error",
    available,
    in_use,
    unknown,

    pub const json_field_names = .{
        .pending = "pending",
        .@"error" = "error",
        .available = "available",
        .in_use = "in-use",
        .unknown = "unknown",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "pending",
            .@"error" => "error",
            .available => "available",
            .in_use => "in-use",
            .unknown => "unknown",
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
