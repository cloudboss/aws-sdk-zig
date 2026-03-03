const std = @import("std");

pub const NodeFilterKey = enum {
    agent_type,
    agent_version,
    computer_name,
    instance_id,
    instance_status,
    ip_address,
    managed_status,
    platform_name,
    platform_type,
    platform_version,
    resource_type,
    organizational_unit_id,
    organizational_unit_path,
    region,
    account_id,

    pub const json_field_names = .{
        .agent_type = "AgentType",
        .agent_version = "AgentVersion",
        .computer_name = "ComputerName",
        .instance_id = "InstanceId",
        .instance_status = "InstanceStatus",
        .ip_address = "IpAddress",
        .managed_status = "ManagedStatus",
        .platform_name = "PlatformName",
        .platform_type = "PlatformType",
        .platform_version = "PlatformVersion",
        .resource_type = "ResourceType",
        .organizational_unit_id = "OrganizationalUnitId",
        .organizational_unit_path = "OrganizationalUnitPath",
        .region = "Region",
        .account_id = "AccountId",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .agent_type => "AgentType",
            .agent_version => "AgentVersion",
            .computer_name => "ComputerName",
            .instance_id => "InstanceId",
            .instance_status => "InstanceStatus",
            .ip_address => "IpAddress",
            .managed_status => "ManagedStatus",
            .platform_name => "PlatformName",
            .platform_type => "PlatformType",
            .platform_version => "PlatformVersion",
            .resource_type => "ResourceType",
            .organizational_unit_id => "OrganizationalUnitId",
            .organizational_unit_path => "OrganizationalUnitPath",
            .region => "Region",
            .account_id => "AccountId",
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
