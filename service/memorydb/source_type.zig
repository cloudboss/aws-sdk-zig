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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
