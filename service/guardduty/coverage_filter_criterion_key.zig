const std = @import("std");

pub const CoverageFilterCriterionKey = enum {
    account_id,
    cluster_name,
    resource_type,
    coverage_status,
    addon_version,
    management_type,
    eks_cluster_name,
    ecs_cluster_name,
    agent_version,
    instance_id,
    cluster_arn,

    pub const json_field_names = .{
        .account_id = "ACCOUNT_ID",
        .cluster_name = "CLUSTER_NAME",
        .resource_type = "RESOURCE_TYPE",
        .coverage_status = "COVERAGE_STATUS",
        .addon_version = "ADDON_VERSION",
        .management_type = "MANAGEMENT_TYPE",
        .eks_cluster_name = "EKS_CLUSTER_NAME",
        .ecs_cluster_name = "ECS_CLUSTER_NAME",
        .agent_version = "AGENT_VERSION",
        .instance_id = "INSTANCE_ID",
        .cluster_arn = "CLUSTER_ARN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_id => "ACCOUNT_ID",
            .cluster_name => "CLUSTER_NAME",
            .resource_type => "RESOURCE_TYPE",
            .coverage_status => "COVERAGE_STATUS",
            .addon_version => "ADDON_VERSION",
            .management_type => "MANAGEMENT_TYPE",
            .eks_cluster_name => "EKS_CLUSTER_NAME",
            .ecs_cluster_name => "ECS_CLUSTER_NAME",
            .agent_version => "AGENT_VERSION",
            .instance_id => "INSTANCE_ID",
            .cluster_arn => "CLUSTER_ARN",
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
