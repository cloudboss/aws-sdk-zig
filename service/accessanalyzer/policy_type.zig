const std = @import("std");

pub const PolicyType = enum {
    identity_policy,
    resource_policy,
    service_control_policy,
    resource_control_policy,

    pub const json_field_names = .{
        .identity_policy = "IDENTITY_POLICY",
        .resource_policy = "RESOURCE_POLICY",
        .service_control_policy = "SERVICE_CONTROL_POLICY",
        .resource_control_policy = "RESOURCE_CONTROL_POLICY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .identity_policy => "IDENTITY_POLICY",
            .resource_policy => "RESOURCE_POLICY",
            .service_control_policy => "SERVICE_CONTROL_POLICY",
            .resource_control_policy => "RESOURCE_CONTROL_POLICY",
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
