const std = @import("std");

/// The policy type.
pub const PolicyType = enum {
    identity_based_policy,
    resource_based_policy,
    permissions_boundary,
    session_policy,
    service_control_policy,
    resource_control_policy,
    vpc_endpoint_policy,

    pub const json_field_names = .{
        .identity_based_policy = "IDENTITY_BASED_POLICY",
        .resource_based_policy = "RESOURCE_BASED_POLICY",
        .permissions_boundary = "PERMISSIONS_BOUNDARY",
        .session_policy = "SESSION_POLICY",
        .service_control_policy = "SERVICE_CONTROL_POLICY",
        .resource_control_policy = "RESOURCE_CONTROL_POLICY",
        .vpc_endpoint_policy = "VPC_ENDPOINT_POLICY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .identity_based_policy => "IDENTITY_BASED_POLICY",
            .resource_based_policy => "RESOURCE_BASED_POLICY",
            .permissions_boundary => "PERMISSIONS_BOUNDARY",
            .session_policy => "SESSION_POLICY",
            .service_control_policy => "SERVICE_CONTROL_POLICY",
            .resource_control_policy => "RESOURCE_CONTROL_POLICY",
            .vpc_endpoint_policy => "VPC_ENDPOINT_POLICY",
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
