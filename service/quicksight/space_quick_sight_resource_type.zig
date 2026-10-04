const std = @import("std");

pub const SpaceQuickSightResourceType = enum {
    topic,
    dashboard,
    knowledge_base,
    action_connector,
    data_set,

    pub const json_field_names = .{
        .topic = "TOPIC",
        .dashboard = "DASHBOARD",
        .knowledge_base = "KNOWLEDGE_BASE",
        .action_connector = "ACTION_CONNECTOR",
        .data_set = "DATA_SET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .topic => "TOPIC",
            .dashboard => "DASHBOARD",
            .knowledge_base => "KNOWLEDGE_BASE",
            .action_connector => "ACTION_CONNECTOR",
            .data_set => "DATA_SET",
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
