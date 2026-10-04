const std = @import("std");

pub const NetworkConnectorLastUpdateStatusReasonCode = enum {
    disallowed_by_vpc_encryption_control,
    ec_2_request_limit_exceeded,
    insufficient_role_permissions,
    internal_error,
    invalid_security_group,
    invalid_subnet,
    subnet_out_of_ip_addresses,

    pub const json_field_names = .{
        .disallowed_by_vpc_encryption_control = "DisallowedByVpcEncryptionControl",
        .ec_2_request_limit_exceeded = "Ec2RequestLimitExceeded",
        .insufficient_role_permissions = "InsufficientRolePermissions",
        .internal_error = "InternalError",
        .invalid_security_group = "InvalidSecurityGroup",
        .invalid_subnet = "InvalidSubnet",
        .subnet_out_of_ip_addresses = "SubnetOutOfIPAddresses",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disallowed_by_vpc_encryption_control => "DisallowedByVpcEncryptionControl",
            .ec_2_request_limit_exceeded => "Ec2RequestLimitExceeded",
            .insufficient_role_permissions => "InsufficientRolePermissions",
            .internal_error => "InternalError",
            .invalid_security_group => "InvalidSecurityGroup",
            .invalid_subnet => "InvalidSubnet",
            .subnet_out_of_ip_addresses => "SubnetOutOfIPAddresses",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
