const std = @import("std");

pub const NotificationRole = enum {
    project_owner,
    project_contributor,
    project_viewer,
    domain_owner,
    project_subscriber,

    pub const json_field_names = .{
        .project_owner = "PROJECT_OWNER",
        .project_contributor = "PROJECT_CONTRIBUTOR",
        .project_viewer = "PROJECT_VIEWER",
        .domain_owner = "DOMAIN_OWNER",
        .project_subscriber = "PROJECT_SUBSCRIBER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .project_owner => "PROJECT_OWNER",
            .project_contributor => "PROJECT_CONTRIBUTOR",
            .project_viewer => "PROJECT_VIEWER",
            .domain_owner => "DOMAIN_OWNER",
            .project_subscriber => "PROJECT_SUBSCRIBER",
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
