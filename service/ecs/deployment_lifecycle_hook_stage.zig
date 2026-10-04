const std = @import("std");

pub const DeploymentLifecycleHookStage = enum {
    reconcile_service,
    pre_scale_up,
    post_scale_up,
    test_traffic_shift,
    post_test_traffic_shift,
    pre_production_traffic_shift,
    production_traffic_shift,
    post_production_traffic_shift,

    pub const json_field_names = .{
        .reconcile_service = "RECONCILE_SERVICE",
        .pre_scale_up = "PRE_SCALE_UP",
        .post_scale_up = "POST_SCALE_UP",
        .test_traffic_shift = "TEST_TRAFFIC_SHIFT",
        .post_test_traffic_shift = "POST_TEST_TRAFFIC_SHIFT",
        .pre_production_traffic_shift = "PRE_PRODUCTION_TRAFFIC_SHIFT",
        .production_traffic_shift = "PRODUCTION_TRAFFIC_SHIFT",
        .post_production_traffic_shift = "POST_PRODUCTION_TRAFFIC_SHIFT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .reconcile_service => "RECONCILE_SERVICE",
            .pre_scale_up => "PRE_SCALE_UP",
            .post_scale_up => "POST_SCALE_UP",
            .test_traffic_shift => "TEST_TRAFFIC_SHIFT",
            .post_test_traffic_shift => "POST_TEST_TRAFFIC_SHIFT",
            .pre_production_traffic_shift => "PRE_PRODUCTION_TRAFFIC_SHIFT",
            .production_traffic_shift => "PRODUCTION_TRAFFIC_SHIFT",
            .post_production_traffic_shift => "POST_PRODUCTION_TRAFFIC_SHIFT",
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
