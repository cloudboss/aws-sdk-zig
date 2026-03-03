const std = @import("std");

pub const ProjectDesignation = enum {
    owner,
    contributor,
    project_catalog_steward,

    pub const json_field_names = .{
        .owner = "OWNER",
        .contributor = "CONTRIBUTOR",
        .project_catalog_steward = "PROJECT_CATALOG_STEWARD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .owner => "OWNER",
            .contributor => "CONTRIBUTOR",
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
