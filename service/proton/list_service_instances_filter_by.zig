const std = @import("std");

pub const ListServiceInstancesFilterBy = enum {
    name,
    deployment_status,
    template_name,
    service_name,
    deployed_template_version_status,
    environment_name,
    last_deployment_attempted_at_before,
    last_deployment_attempted_at_after,
    created_at_before,
    created_at_after,

    pub const json_field_names = .{
        .name = "name",
        .deployment_status = "deploymentStatus",
        .template_name = "templateName",
        .service_name = "serviceName",
        .deployed_template_version_status = "deployedTemplateVersionStatus",
        .environment_name = "environmentName",
        .last_deployment_attempted_at_before = "lastDeploymentAttemptedAtBefore",
        .last_deployment_attempted_at_after = "lastDeploymentAttemptedAtAfter",
        .created_at_before = "createdAtBefore",
        .created_at_after = "createdAtAfter",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "name",
            .deployment_status => "deploymentStatus",
            .template_name => "templateName",
            .service_name => "serviceName",
            .deployed_template_version_status => "deployedTemplateVersionStatus",
            .environment_name => "environmentName",
            .last_deployment_attempted_at_before => "lastDeploymentAttemptedAtBefore",
            .last_deployment_attempted_at_after => "lastDeploymentAttemptedAtAfter",
            .created_at_before => "createdAtBefore",
            .created_at_after => "createdAtAfter",
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
