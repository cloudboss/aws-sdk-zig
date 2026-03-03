const std = @import("std");

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
        .cognitio_user_pool = "COGNITO_USER_POOL",
        .app_runner_service = "APP_RUNNER_SERVICE",
        .verified_access_instance = "VERIFIED_ACCESS_INSTANCE",
        .amplify = "AMPLIFY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .application_load_balancer => "APPLICATION_LOAD_BALANCER",
            .api_gateway => "API_GATEWAY",
            .appsync => "APPSYNC",
            .cognitio_user_pool => "COGNITO_USER_POOL",
            .app_runner_service => "APP_RUNNER_SERVICE",
            .verified_access_instance => "VERIFIED_ACCESS_INSTANCE",
            .amplify => "AMPLIFY",
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
