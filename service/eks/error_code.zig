const std = @import("std");

pub const ErrorCode = enum {
    subnet_not_found,
    security_group_not_found,
    eni_limit_reached,
    ip_not_available,
    access_denied,
    operation_not_permitted,
    vpc_id_not_found,
    unknown,
    node_creation_failure,
    pod_eviction_failure,
    insufficient_free_addresses,
    cluster_unreachable,
    insufficient_number_of_replicas,
    configuration_conflict,
    admission_request_denied,
    unsupported_addon_modification,
    k8_s_resource_not_found,

    pub const json_field_names = .{
        .subnet_not_found = "SubnetNotFound",
        .security_group_not_found = "SecurityGroupNotFound",
        .eni_limit_reached = "EniLimitReached",
        .ip_not_available = "IpNotAvailable",
        .access_denied = "AccessDenied",
        .operation_not_permitted = "OperationNotPermitted",
        .vpc_id_not_found = "VpcIdNotFound",
        .unknown = "Unknown",
        .node_creation_failure = "NodeCreationFailure",
        .pod_eviction_failure = "PodEvictionFailure",
        .insufficient_free_addresses = "InsufficientFreeAddresses",
        .cluster_unreachable = "ClusterUnreachable",
        .insufficient_number_of_replicas = "InsufficientNumberOfReplicas",
        .configuration_conflict = "ConfigurationConflict",
        .admission_request_denied = "AdmissionRequestDenied",
        .unsupported_addon_modification = "UnsupportedAddonModification",
        .k8_s_resource_not_found = "K8sResourceNotFound",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .subnet_not_found => "SubnetNotFound",
            .security_group_not_found => "SecurityGroupNotFound",
            .eni_limit_reached => "EniLimitReached",
            .ip_not_available => "IpNotAvailable",
            .access_denied => "AccessDenied",
            .operation_not_permitted => "OperationNotPermitted",
            .vpc_id_not_found => "VpcIdNotFound",
            .unknown => "Unknown",
            .node_creation_failure => "NodeCreationFailure",
            .pod_eviction_failure => "PodEvictionFailure",
            .insufficient_free_addresses => "InsufficientFreeAddresses",
            .cluster_unreachable => "ClusterUnreachable",
            .insufficient_number_of_replicas => "InsufficientNumberOfReplicas",
            .configuration_conflict => "ConfigurationConflict",
            .admission_request_denied => "AdmissionRequestDenied",
            .unsupported_addon_modification => "UnsupportedAddonModification",
            .k8_s_resource_not_found => "K8sResourceNotFound",
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
