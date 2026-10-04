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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
