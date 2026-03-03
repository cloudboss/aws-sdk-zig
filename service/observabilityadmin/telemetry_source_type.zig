const std = @import("std");

/// Specifies the type of telemetry source for a resource, such as EKS cluster
/// logs.
pub const TelemetrySourceType = enum {
    vpc_flow_logs,
    route53_resolver_query_logs,
    eks_audit_logs,
    eks_authenticator_logs,
    eks_controller_manager_logs,
    eks_scheduler_logs,
    eks_api_logs,

    pub const json_field_names = .{
        .vpc_flow_logs = "VPC_FLOW_LOGS",
        .route53_resolver_query_logs = "ROUTE53_RESOLVER_QUERY_LOGS",
        .eks_audit_logs = "EKS_AUDIT_LOGS",
        .eks_authenticator_logs = "EKS_AUTHENTICATOR_LOGS",
        .eks_controller_manager_logs = "EKS_CONTROLLER_MANAGER_LOGS",
        .eks_scheduler_logs = "EKS_SCHEDULER_LOGS",
        .eks_api_logs = "EKS_API_LOGS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vpc_flow_logs => "VPC_FLOW_LOGS",
            .route53_resolver_query_logs => "ROUTE53_RESOLVER_QUERY_LOGS",
            .eks_audit_logs => "EKS_AUDIT_LOGS",
            .eks_authenticator_logs => "EKS_AUTHENTICATOR_LOGS",
            .eks_controller_manager_logs => "EKS_CONTROLLER_MANAGER_LOGS",
            .eks_scheduler_logs => "EKS_SCHEDULER_LOGS",
            .eks_api_logs => "EKS_API_LOGS",
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
