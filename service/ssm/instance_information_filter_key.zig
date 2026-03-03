const std = @import("std");

pub const InstanceInformationFilterKey = enum {
    instance_ids,
    agent_version,
    ping_status,
    platform_types,
    activation_ids,
    iam_role,
    resource_type,
    association_status,

    pub const json_field_names = .{
        .instance_ids = "InstanceIds",
        .agent_version = "AgentVersion",
        .ping_status = "PingStatus",
        .platform_types = "PlatformTypes",
        .activation_ids = "ActivationIds",
        .iam_role = "IamRole",
        .resource_type = "ResourceType",
        .association_status = "AssociationStatus",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_ids => "InstanceIds",
            .agent_version => "AgentVersion",
            .ping_status => "PingStatus",
            .platform_types => "PlatformTypes",
            .activation_ids => "ActivationIds",
            .iam_role => "IamRole",
            .resource_type => "ResourceType",
            .association_status => "AssociationStatus",
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
