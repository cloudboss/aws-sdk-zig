const std = @import("std");

/// - When set to NORMAL (default), the deinterlacer does not convert frames
/// that are tagged in metadata as progressive. It will only convert those that
/// are tagged as some other type. - When set to FORCE_ALL_FRAMES, the
/// deinterlacer converts every frame to progressive - even those that are
/// already tagged as progressive. Turn Force mode on only if there is a good
/// chance that the metadata has tagged frames as progressive when they are not
/// progressive. Do not turn on otherwise; processing frames that are already
/// progressive into progressive will probably result in lower quality video.
pub const DeinterlacerControl = enum {
    force_all_frames,
    normal,

    pub const json_field_names = .{
        .force_all_frames = "FORCE_ALL_FRAMES",
        .normal = "NORMAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .force_all_frames => "FORCE_ALL_FRAMES",
            .normal => "NORMAL",
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
