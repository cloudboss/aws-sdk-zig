const std = @import("std");

pub const NodeAttributeName = enum {
    agent_version,
    platform_name,
    platform_type,
    platform_version,
    region,
    resource_type,
    source_type,
    availability_zone,

    pub const json_field_names = .{
        .agent_version = "AgentVersion",
        .platform_name = "PlatformName",
        .platform_type = "PlatformType",
        .platform_version = "PlatformVersion",
        .region = "Region",
        .resource_type = "ResourceType",
        .source_type = "SourceType",
        .availability_zone = "AvailabilityZone",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .agent_version => "AgentVersion",
            .platform_name => "PlatformName",
            .platform_type => "PlatformType",
            .platform_version => "PlatformVersion",
            .region => "Region",
            .resource_type => "ResourceType",
            .source_type => "SourceType",
            .availability_zone => "AvailabilityZone",
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
