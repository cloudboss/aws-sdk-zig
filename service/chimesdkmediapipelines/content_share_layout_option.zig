const std = @import("std");

pub const ContentShareLayoutOption = enum {
    presenter_only,
    horizontal,
    vertical,
    active_speaker_only,

    pub const json_field_names = .{
        .presenter_only = "PresenterOnly",
        .horizontal = "Horizontal",
        .vertical = "Vertical",
        .active_speaker_only = "ActiveSpeakerOnly",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .presenter_only => "PresenterOnly",
            .horizontal => "Horizontal",
            .vertical => "Vertical",
            .active_speaker_only => "ActiveSpeakerOnly",
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
