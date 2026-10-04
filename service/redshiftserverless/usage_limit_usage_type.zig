const std = @import("std");

pub const UsageLimitUsageType = enum {
    serverless_compute,
    cross_region_datasharing,

    pub const json_field_names = .{
        .serverless_compute = "serverless-compute",
        .cross_region_datasharing = "cross-region-datasharing",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .serverless_compute => "serverless-compute",
            .cross_region_datasharing => "cross-region-datasharing",
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
