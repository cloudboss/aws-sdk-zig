const std = @import("std");

pub const OriginRequestPolicyHeaderBehavior = enum {
    none,
    whitelist,
    all_viewer,
    all_viewer_and_whitelist_cloud_front,
    all_except,

    pub const json_field_names = .{
        .none = "none",
        .whitelist = "whitelist",
        .all_viewer = "allViewer",
        .all_viewer_and_whitelist_cloud_front = "allViewerAndWhitelistCloudFront",
        .all_except = "allExcept",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "none",
            .whitelist => "whitelist",
            .all_viewer => "allViewer",
            .all_viewer_and_whitelist_cloud_front => "allViewerAndWhitelistCloudFront",
            .all_except => "allExcept",
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
