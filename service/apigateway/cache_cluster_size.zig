const std = @import("std");

/// Returns the size of the CacheCluster.
pub const CacheClusterSize = enum {
    size_0_point_5_gb,
    size_1_point_6_gb,
    size_6_point_1_gb,
    size_13_point_5_gb,
    size_28_point_4_gb,
    size_58_point_2_gb,
    size_118_gb,
    size_237_gb,

    pub const json_field_names = .{
        .size_0_point_5_gb = "0.5",
        .size_1_point_6_gb = "1.6",
        .size_6_point_1_gb = "6.1",
        .size_13_point_5_gb = "13.5",
        .size_28_point_4_gb = "28.4",
        .size_58_point_2_gb = "58.2",
        .size_118_gb = "118",
        .size_237_gb = "237",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .size_0_point_5_gb => "0.5",
            .size_1_point_6_gb => "1.6",
            .size_6_point_1_gb => "6.1",
            .size_13_point_5_gb => "13.5",
            .size_28_point_4_gb => "28.4",
            .size_58_point_2_gb => "58.2",
            .size_118_gb => "118",
            .size_237_gb => "237",
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
