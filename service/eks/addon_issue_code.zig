const std = @import("std");

pub const AddonIssueCode = enum {
    access_denied,
    internal_failure,
    cluster_unreachable,
    insufficient_number_of_replicas,
    configuration_conflict,
    admission_request_denied,
    unsupported_addon_modification,
    k8_s_resource_not_found,
    addon_subscription_needed,
    addon_permission_failure,

    pub const json_field_names = .{
        .access_denied = "AccessDenied",
        .internal_failure = "InternalFailure",
        .cluster_unreachable = "ClusterUnreachable",
        .insufficient_number_of_replicas = "InsufficientNumberOfReplicas",
        .configuration_conflict = "ConfigurationConflict",
        .admission_request_denied = "AdmissionRequestDenied",
        .unsupported_addon_modification = "UnsupportedAddonModification",
        .k8_s_resource_not_found = "K8sResourceNotFound",
        .addon_subscription_needed = "AddonSubscriptionNeeded",
        .addon_permission_failure = "AddonPermissionFailure",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied => "AccessDenied",
            .internal_failure => "InternalFailure",
            .cluster_unreachable => "ClusterUnreachable",
            .insufficient_number_of_replicas => "InsufficientNumberOfReplicas",
            .configuration_conflict => "ConfigurationConflict",
            .admission_request_denied => "AdmissionRequestDenied",
            .unsupported_addon_modification => "UnsupportedAddonModification",
            .k8_s_resource_not_found => "K8sResourceNotFound",
            .addon_subscription_needed => "AddonSubscriptionNeeded",
            .addon_permission_failure => "AddonPermissionFailure",
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
