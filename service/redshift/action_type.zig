const std = @import("std");

pub const ActionType = enum {
    restore_cluster,
    recommend_node_config,
    resize_cluster,

    pub const json_field_names = .{
        .restore_cluster = "restore-cluster",
        .recommend_node_config = "recommend-node-config",
        .resize_cluster = "resize-cluster",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .restore_cluster => "restore-cluster",
            .recommend_node_config => "recommend-node-config",
            .resize_cluster => "resize-cluster",
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
