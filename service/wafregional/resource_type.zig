pub const ResourceType = enum {
    application_load_balancer,
    api_gateway,

    pub const json_field_names = .{
        .application_load_balancer = "APPLICATION_LOAD_BALANCER",
        .api_gateway = "API_GATEWAY",
    };
};
