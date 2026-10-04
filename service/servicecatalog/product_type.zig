const std = @import("std");

pub const ProductType = enum {
    cloud_formation_template,
    marketplace,
    terraform_open_source,
    terraform_cloud,
    external,

    pub const json_field_names = .{
        .cloud_formation_template = "CLOUD_FORMATION_TEMPLATE",
        .marketplace = "MARKETPLACE",
        .terraform_open_source = "TERRAFORM_OPEN_SOURCE",
        .terraform_cloud = "TERRAFORM_CLOUD",
        .external = "EXTERNAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cloud_formation_template => "CLOUD_FORMATION_TEMPLATE",
            .marketplace => "MARKETPLACE",
            .terraform_open_source => "TERRAFORM_OPEN_SOURCE",
            .terraform_cloud => "TERRAFORM_CLOUD",
            .external => "EXTERNAL",
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
