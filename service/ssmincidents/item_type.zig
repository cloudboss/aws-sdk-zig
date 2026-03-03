const std = @import("std");

pub const ItemType = enum {
    analysis,
    incident,
    metric,
    parent,
    attachment,
    other,
    automation,
    involved_resource,
    task,

    pub const json_field_names = .{
        .analysis = "ANALYSIS",
        .incident = "INCIDENT",
        .metric = "METRIC",
        .parent = "PARENT",
        .attachment = "ATTACHMENT",
        .other = "OTHER",
        .automation = "AUTOMATION",
        .involved_resource = "INVOLVED_RESOURCE",
        .task = "TASK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .analysis => "ANALYSIS",
            .incident => "INCIDENT",
            .metric => "METRIC",
            .parent => "PARENT",
            .attachment => "ATTACHMENT",
            .other => "OTHER",
            .automation => "AUTOMATION",
            .involved_resource => "INVOLVED_RESOURCE",
            .task => "TASK",
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
