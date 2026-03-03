const std = @import("std");

pub const BatchDeleteClusterNodesErrorCode = enum {
    node_id_not_found,
    invalid_node_status,
    node_id_in_use,

    pub const json_field_names = .{
        .node_id_not_found = "NodeIdNotFound",
        .invalid_node_status = "InvalidNodeStatus",
        .node_id_in_use = "NodeIdInUse",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .node_id_not_found => "NodeIdNotFound",
            .invalid_node_status => "InvalidNodeStatus",
            .node_id_in_use => "NodeIdInUse",
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
