const std = @import("std");

pub const UserDesignation = enum {
    project_owner,
    project_contributor,
    project_catalog_viewer,
    project_catalog_consumer,
    project_catalog_steward,

    pub const json_field_names = .{
        .project_owner = "PROJECT_OWNER",
        .project_contributor = "PROJECT_CONTRIBUTOR",
        .project_catalog_viewer = "PROJECT_CATALOG_VIEWER",
        .project_catalog_consumer = "PROJECT_CATALOG_CONSUMER",
        .project_catalog_steward = "PROJECT_CATALOG_STEWARD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .project_owner => "PROJECT_OWNER",
            .project_contributor => "PROJECT_CONTRIBUTOR",
            .project_catalog_viewer => "PROJECT_CATALOG_VIEWER",
            .project_catalog_consumer => "PROJECT_CATALOG_CONSUMER",
            .project_catalog_steward => "PROJECT_CATALOG_STEWARD",
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
