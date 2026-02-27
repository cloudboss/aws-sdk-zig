pub const ResourceType = enum {
    application_load_balancer,
    api_gateway,
    appsync,
    cognitio_user_pool,
    app_runner_service,
    verified_access_instance,
    amplify,

    pub const json_field_names = .{
        .application_load_balancer = "APPLICATION_LOAD_BALANCER",
        .api_gateway = "API_GATEWAY",
        .appsync = "APPSYNC",
        .cognitio_user_pool = "COGNITIO_USER_POOL",
        .app_runner_service = "APP_RUNNER_SERVICE",
        .verified_access_instance = "VERIFIED_ACCESS_INSTANCE",
        .amplify = "AMPLIFY",
    };
};
