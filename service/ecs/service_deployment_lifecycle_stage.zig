pub const ServiceDeploymentLifecycleStage = enum {
    reconcile_service,
    pre_scale_up,
    scale_up,
    post_scale_up,
    test_traffic_shift,
    post_test_traffic_shift,
    production_traffic_shift,
    post_production_traffic_shift,
    bake_time,
    clean_up,

    pub const json_field_names = .{
        .reconcile_service = "RECONCILE_SERVICE",
        .pre_scale_up = "PRE_SCALE_UP",
        .scale_up = "SCALE_UP",
        .post_scale_up = "POST_SCALE_UP",
        .test_traffic_shift = "TEST_TRAFFIC_SHIFT",
        .post_test_traffic_shift = "POST_TEST_TRAFFIC_SHIFT",
        .production_traffic_shift = "PRODUCTION_TRAFFIC_SHIFT",
        .post_production_traffic_shift = "POST_PRODUCTION_TRAFFIC_SHIFT",
        .bake_time = "BAKE_TIME",
        .clean_up = "CLEAN_UP",
    };
};
