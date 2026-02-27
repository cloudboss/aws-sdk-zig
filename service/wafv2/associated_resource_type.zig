pub const AssociatedResourceType = enum {
    cloudfront,
    api_gateway,
    cognito_user_pool,
    app_runner_service,
    verified_access_instance,

    pub const json_field_names = .{
        .cloudfront = "CLOUDFRONT",
        .api_gateway = "API_GATEWAY",
        .cognito_user_pool = "COGNITO_USER_POOL",
        .app_runner_service = "APP_RUNNER_SERVICE",
        .verified_access_instance = "VERIFIED_ACCESS_INSTANCE",
    };
};
