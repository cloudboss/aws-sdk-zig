const std = @import("std");

/// Used in CreateClusterSummary, DescribeClusterSummary, DescribeClusterResult,
/// UpdateClusterResult.
pub const ClusterType = enum {
    on_premises,

    pub const json_field_names = .{
        .on_premises = "ON_PREMISES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .on_premises => "ON_PREMISES",
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
