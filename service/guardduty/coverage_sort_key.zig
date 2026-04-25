const std = @import("std");

pub const CoverageSortKey = enum {
    account_id,
    coverage_status,
    issue,
    addon_version,
    updated_at,
    cluster_name,
    eks_cluster_name,
    ecs_cluster_name,
    instance_id,

    pub const json_field_names = .{
        .account_id = "ACCOUNT_ID",
        .coverage_status = "COVERAGE_STATUS",
        .issue = "ISSUE",
        .addon_version = "ADDON_VERSION",
        .updated_at = "UPDATED_AT",
        .cluster_name = "CLUSTER_NAME",
        .eks_cluster_name = "EKS_CLUSTER_NAME",
        .ecs_cluster_name = "ECS_CLUSTER_NAME",
        .instance_id = "INSTANCE_ID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_id => "ACCOUNT_ID",
            .coverage_status => "COVERAGE_STATUS",
            .issue => "ISSUE",
            .addon_version => "ADDON_VERSION",
            .updated_at => "UPDATED_AT",
            .cluster_name => "CLUSTER_NAME",
            .eks_cluster_name => "EKS_CLUSTER_NAME",
            .ecs_cluster_name => "ECS_CLUSTER_NAME",
            .instance_id => "INSTANCE_ID",
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
