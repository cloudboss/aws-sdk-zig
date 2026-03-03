const std = @import("std");

pub const ConnectionErrorCodeType = enum {
    invalid_credentials,
    cluster_not_found,
    network_errors,
    internal_error,
    insufficient_cloudhsm_hsms,
    user_locked_out,
    user_not_found,
    user_logged_in,
    subnet_not_found,
    insufficient_free_addresses_in_subnet,
    xks_proxy_access_denied,
    xks_proxy_not_reachable,
    xks_vpc_endpoint_service_not_found,
    xks_proxy_invalid_response,
    xks_proxy_invalid_configuration,
    xks_vpc_endpoint_service_invalid_configuration,
    xks_proxy_timed_out,
    xks_proxy_invalid_tls_configuration,

    pub const json_field_names = .{
        .invalid_credentials = "INVALID_CREDENTIALS",
        .cluster_not_found = "CLUSTER_NOT_FOUND",
        .network_errors = "NETWORK_ERRORS",
        .internal_error = "INTERNAL_ERROR",
        .insufficient_cloudhsm_hsms = "INSUFFICIENT_CLOUDHSM_HSMS",
        .user_locked_out = "USER_LOCKED_OUT",
        .user_not_found = "USER_NOT_FOUND",
        .user_logged_in = "USER_LOGGED_IN",
        .subnet_not_found = "SUBNET_NOT_FOUND",
        .insufficient_free_addresses_in_subnet = "INSUFFICIENT_FREE_ADDRESSES_IN_SUBNET",
        .xks_proxy_access_denied = "XKS_PROXY_ACCESS_DENIED",
        .xks_proxy_not_reachable = "XKS_PROXY_NOT_REACHABLE",
        .xks_vpc_endpoint_service_not_found = "XKS_VPC_ENDPOINT_SERVICE_NOT_FOUND",
        .xks_proxy_invalid_response = "XKS_PROXY_INVALID_RESPONSE",
        .xks_proxy_invalid_configuration = "XKS_PROXY_INVALID_CONFIGURATION",
        .xks_vpc_endpoint_service_invalid_configuration = "XKS_VPC_ENDPOINT_SERVICE_INVALID_CONFIGURATION",
        .xks_proxy_timed_out = "XKS_PROXY_TIMED_OUT",
        .xks_proxy_invalid_tls_configuration = "XKS_PROXY_INVALID_TLS_CONFIGURATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_credentials => "INVALID_CREDENTIALS",
            .cluster_not_found => "CLUSTER_NOT_FOUND",
            .network_errors => "NETWORK_ERRORS",
            .internal_error => "INTERNAL_ERROR",
            .insufficient_cloudhsm_hsms => "INSUFFICIENT_CLOUDHSM_HSMS",
            .user_locked_out => "USER_LOCKED_OUT",
            .user_not_found => "USER_NOT_FOUND",
            .user_logged_in => "USER_LOGGED_IN",
            .subnet_not_found => "SUBNET_NOT_FOUND",
            .insufficient_free_addresses_in_subnet => "INSUFFICIENT_FREE_ADDRESSES_IN_SUBNET",
            .xks_proxy_access_denied => "XKS_PROXY_ACCESS_DENIED",
            .xks_proxy_not_reachable => "XKS_PROXY_NOT_REACHABLE",
            .xks_vpc_endpoint_service_not_found => "XKS_VPC_ENDPOINT_SERVICE_NOT_FOUND",
            .xks_proxy_invalid_response => "XKS_PROXY_INVALID_RESPONSE",
            .xks_proxy_invalid_configuration => "XKS_PROXY_INVALID_CONFIGURATION",
            .xks_vpc_endpoint_service_invalid_configuration => "XKS_VPC_ENDPOINT_SERVICE_INVALID_CONFIGURATION",
            .xks_proxy_timed_out => "XKS_PROXY_TIMED_OUT",
            .xks_proxy_invalid_tls_configuration => "XKS_PROXY_INVALID_TLS_CONFIGURATION",
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
