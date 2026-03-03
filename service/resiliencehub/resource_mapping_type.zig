const std = @import("std");

pub const ResourceMappingType = enum {
    cfn_stack,
    resource,
    app_registry_app,
    resource_group,
    terraform,
    eks,

    pub const json_field_names = .{
        .cfn_stack = "CfnStack",
        .resource = "Resource",
        .app_registry_app = "AppRegistryApp",
        .resource_group = "ResourceGroup",
        .terraform = "Terraform",
        .eks = "EKS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cfn_stack => "CfnStack",
            .resource => "Resource",
            .app_registry_app => "AppRegistryApp",
            .resource_group => "ResourceGroup",
            .terraform => "Terraform",
            .eks => "EKS",
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
