const std = @import("std");

pub const DashPeriodTrigger = enum {
    avails,
    drm_key_rotation,
    source_changes,
    source_disruptions,
    none,

    pub const json_field_names = .{
        .avails = "AVAILS",
        .drm_key_rotation = "DRM_KEY_ROTATION",
        .source_changes = "SOURCE_CHANGES",
        .source_disruptions = "SOURCE_DISRUPTIONS",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .avails => "AVAILS",
            .drm_key_rotation => "DRM_KEY_ROTATION",
            .source_changes => "SOURCE_CHANGES",
            .source_disruptions => "SOURCE_DISRUPTIONS",
            .none => "NONE",
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
