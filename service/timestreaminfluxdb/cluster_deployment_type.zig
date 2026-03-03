const std = @import("std");

pub const ClusterDeploymentType = enum {
    multi_node_read_replicas,

    pub const json_field_names = .{
        .multi_node_read_replicas = "MULTI_NODE_READ_REPLICAS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .multi_node_read_replicas => "MULTI_NODE_READ_REPLICAS",
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
