const std = @import("std");

pub const BuildComputeType = enum {
    standard_8_gb,
    large_16_gb,
    xlarge_72_gb,

    pub const json_field_names = .{
        .standard_8_gb = "STANDARD_8GB",
        .large_16_gb = "LARGE_16GB",
        .xlarge_72_gb = "XLARGE_72GB",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard_8_gb => "STANDARD_8GB",
            .large_16_gb => "LARGE_16GB",
            .xlarge_72_gb => "XLARGE_72GB",
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
