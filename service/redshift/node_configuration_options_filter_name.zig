const std = @import("std");

pub const NodeConfigurationOptionsFilterName = enum {
    node_type,
    num_nodes,
    estimated_disk_utilization_percent,
    mode,

    pub const json_field_names = .{
        .node_type = "NodeType",
        .num_nodes = "NumberOfNodes",
        .estimated_disk_utilization_percent = "EstimatedDiskUtilizationPercent",
        .mode = "Mode",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .node_type => "NodeType",
            .num_nodes => "NumberOfNodes",
            .estimated_disk_utilization_percent => "EstimatedDiskUtilizationPercent",
            .mode => "Mode",
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
