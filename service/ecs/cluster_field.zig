const std = @import("std");

pub const ClusterField = enum {
    attachments,
    configurations,
    settings,
    statistics,
    tags,

    pub const json_field_names = .{
        .attachments = "ATTACHMENTS",
        .configurations = "CONFIGURATIONS",
        .settings = "SETTINGS",
        .statistics = "STATISTICS",
        .tags = "TAGS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .attachments => "ATTACHMENTS",
            .configurations => "CONFIGURATIONS",
            .settings => "SETTINGS",
            .statistics => "STATISTICS",
            .tags => "TAGS",
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
