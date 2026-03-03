const std = @import("std");

pub const SourceType = enum {
    node,
    parameter_group,
    subnet_group,
    cluster,
    user,
    acl,

    pub const json_field_names = .{
        .node = "node",
        .parameter_group = "parameter-group",
        .subnet_group = "subnet-group",
        .cluster = "cluster",
        .user = "user",
        .acl = "acl",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .node => "node",
            .parameter_group => "parameter-group",
            .subnet_group => "subnet-group",
            .cluster => "cluster",
            .user => "user",
            .acl => "acl",
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
