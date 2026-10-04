const std = @import("std");

pub const UsageLimitFeatureType = enum {
    spectrum,
    concurrency_scaling,
    cross_region_datasharing,
    extra_compute_for_automatic_optimization,

    pub const json_field_names = .{
        .spectrum = "spectrum",
        .concurrency_scaling = "concurrency-scaling",
        .cross_region_datasharing = "cross-region-datasharing",
        .extra_compute_for_automatic_optimization = "extra-compute-for-automatic-optimization",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .spectrum => "spectrum",
            .concurrency_scaling => "concurrency-scaling",
            .cross_region_datasharing => "cross-region-datasharing",
            .extra_compute_for_automatic_optimization => "extra-compute-for-automatic-optimization",
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
