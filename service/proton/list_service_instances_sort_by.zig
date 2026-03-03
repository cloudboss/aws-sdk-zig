const std = @import("std");

pub const ListServiceInstancesSortBy = enum {
    name,
    deployment_status,
    template_name,
    service_name,
    environment_name,
    last_deployment_attempted_at,
    created_at,

    pub const json_field_names = .{
        .name = "name",
        .deployment_status = "deploymentStatus",
        .template_name = "templateName",
        .service_name = "serviceName",
        .environment_name = "environmentName",
        .last_deployment_attempted_at = "lastDeploymentAttemptedAt",
        .created_at = "createdAt",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "name",
            .deployment_status => "deploymentStatus",
            .template_name => "templateName",
            .service_name => "serviceName",
            .environment_name => "environmentName",
            .last_deployment_attempted_at => "lastDeploymentAttemptedAt",
            .created_at => "createdAt",
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
