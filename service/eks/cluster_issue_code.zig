const std = @import("std");

pub const ClusterIssueCode = enum {
    access_denied,
    cluster_unreachable,
    configuration_conflict,
    internal_failure,
    resource_limit_exceeded,
    resource_not_found,
    iam_role_not_found,
    vpc_not_found,
    insufficient_free_addresses,
    ec2_service_not_subscribed,
    ec2_subnet_not_found,
    ec2_security_group_not_found,
    kms_grant_revoked,
    kms_key_not_found,
    kms_key_marked_for_deletion,
    kms_key_disabled,
    sts_regional_endpoint_disabled,
    unsupported_version,
    other,

    pub const json_field_names = .{
        .access_denied = "AccessDenied",
        .cluster_unreachable = "ClusterUnreachable",
        .configuration_conflict = "ConfigurationConflict",
        .internal_failure = "InternalFailure",
        .resource_limit_exceeded = "ResourceLimitExceeded",
        .resource_not_found = "ResourceNotFound",
        .iam_role_not_found = "IamRoleNotFound",
        .vpc_not_found = "VpcNotFound",
        .insufficient_free_addresses = "InsufficientFreeAddresses",
        .ec2_service_not_subscribed = "Ec2ServiceNotSubscribed",
        .ec2_subnet_not_found = "Ec2SubnetNotFound",
        .ec2_security_group_not_found = "Ec2SecurityGroupNotFound",
        .kms_grant_revoked = "KmsGrantRevoked",
        .kms_key_not_found = "KmsKeyNotFound",
        .kms_key_marked_for_deletion = "KmsKeyMarkedForDeletion",
        .kms_key_disabled = "KmsKeyDisabled",
        .sts_regional_endpoint_disabled = "StsRegionalEndpointDisabled",
        .unsupported_version = "UnsupportedVersion",
        .other = "Other",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied => "AccessDenied",
            .cluster_unreachable => "ClusterUnreachable",
            .configuration_conflict => "ConfigurationConflict",
            .internal_failure => "InternalFailure",
            .resource_limit_exceeded => "ResourceLimitExceeded",
            .resource_not_found => "ResourceNotFound",
            .iam_role_not_found => "IamRoleNotFound",
            .vpc_not_found => "VpcNotFound",
            .insufficient_free_addresses => "InsufficientFreeAddresses",
            .ec2_service_not_subscribed => "Ec2ServiceNotSubscribed",
            .ec2_subnet_not_found => "Ec2SubnetNotFound",
            .ec2_security_group_not_found => "Ec2SecurityGroupNotFound",
            .kms_grant_revoked => "KmsGrantRevoked",
            .kms_key_not_found => "KmsKeyNotFound",
            .kms_key_marked_for_deletion => "KmsKeyMarkedForDeletion",
            .kms_key_disabled => "KmsKeyDisabled",
            .sts_regional_endpoint_disabled => "StsRegionalEndpointDisabled",
            .unsupported_version => "UnsupportedVersion",
            .other => "Other",
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
