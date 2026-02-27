pub const ConnectorStatusReason = enum {
    ca_certificate_registration_failed,
    directory_access_denied,
    internal_failure,
    insufficient_free_addresses,
    invalid_subnet_ip_protocol,
    privateca_access_denied,
    privateca_resource_not_found,
    security_group_not_in_vpc,
    vpc_access_denied,
    vpc_endpoint_limit_exceeded,
    vpc_resource_not_found,

    pub const json_field_names = .{
        .ca_certificate_registration_failed = "CA_CERTIFICATE_REGISTRATION_FAILED",
        .directory_access_denied = "DIRECTORY_ACCESS_DENIED",
        .internal_failure = "INTERNAL_FAILURE",
        .insufficient_free_addresses = "INSUFFICIENT_FREE_ADDRESSES",
        .invalid_subnet_ip_protocol = "INVALID_SUBNET_IP_PROTOCOL",
        .privateca_access_denied = "PRIVATECA_ACCESS_DENIED",
        .privateca_resource_not_found = "PRIVATECA_RESOURCE_NOT_FOUND",
        .security_group_not_in_vpc = "SECURITY_GROUP_NOT_IN_VPC",
        .vpc_access_denied = "VPC_ACCESS_DENIED",
        .vpc_endpoint_limit_exceeded = "VPC_ENDPOINT_LIMIT_EXCEEDED",
        .vpc_resource_not_found = "VPC_RESOURCE_NOT_FOUND",
    };
};
