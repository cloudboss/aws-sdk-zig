const std = @import("std");

pub const PresetSpeke20Video = enum {
    preset_video_1,
    preset_video_2,
    preset_video_3,
    preset_video_4,
    preset_video_5,
    preset_video_6,
    preset_video_7,
    preset_video_8,
    shared,
    unencrypted,

    pub const json_field_names = .{
        .preset_video_1 = "PRESET-VIDEO-1",
        .preset_video_2 = "PRESET-VIDEO-2",
        .preset_video_3 = "PRESET-VIDEO-3",
        .preset_video_4 = "PRESET-VIDEO-4",
        .preset_video_5 = "PRESET-VIDEO-5",
        .preset_video_6 = "PRESET-VIDEO-6",
        .preset_video_7 = "PRESET-VIDEO-7",
        .preset_video_8 = "PRESET-VIDEO-8",
        .shared = "SHARED",
        .unencrypted = "UNENCRYPTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .preset_video_1 => "PRESET-VIDEO-1",
            .preset_video_2 => "PRESET-VIDEO-2",
            .preset_video_3 => "PRESET-VIDEO-3",
            .preset_video_4 => "PRESET-VIDEO-4",
            .preset_video_5 => "PRESET-VIDEO-5",
            .preset_video_6 => "PRESET-VIDEO-6",
            .preset_video_7 => "PRESET-VIDEO-7",
            .preset_video_8 => "PRESET-VIDEO-8",
            .shared => "SHARED",
            .unencrypted => "UNENCRYPTED",
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
