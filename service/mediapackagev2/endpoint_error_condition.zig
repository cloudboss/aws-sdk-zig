const std = @import("std");

pub const EndpointErrorCondition = enum {
    stale_manifest,
    incomplete_manifest,
    missing_drm_key,
    slate_input,

    pub const json_field_names = .{
        .stale_manifest = "STALE_MANIFEST",
        .incomplete_manifest = "INCOMPLETE_MANIFEST",
        .missing_drm_key = "MISSING_DRM_KEY",
        .slate_input = "SLATE_INPUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .stale_manifest => "STALE_MANIFEST",
            .incomplete_manifest => "INCOMPLETE_MANIFEST",
            .missing_drm_key => "MISSING_DRM_KEY",
            .slate_input => "SLATE_INPUT",
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
