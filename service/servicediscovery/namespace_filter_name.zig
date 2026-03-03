const std = @import("std");

pub const NamespaceFilterName = enum {
    @"type",
    name,
    http_name,
    resource_owner,

    pub const json_field_names = .{
        .@"type" = "TYPE",
        .name = "NAME",
        .http_name = "HTTP_NAME",
        .resource_owner = "RESOURCE_OWNER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .@"type" => "TYPE",
            .name => "NAME",
            .http_name => "HTTP_NAME",
            .resource_owner => "RESOURCE_OWNER",
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
