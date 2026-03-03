const std = @import("std");

/// If you select ALIGN_TO_VIDEO, MediaConvert writes captions and data packets
/// with Presentation Timestamp (PTS) values greater than or equal to the first
/// video packet PTS (MediaConvert drops captions and data packets with lesser
/// PTS values). Keep the default value AUTO to allow all PTS values.
pub const M3u8DataPtsControl = enum {
    auto,
    align_to_video,

    pub const json_field_names = .{
        .auto = "AUTO",
        .align_to_video = "ALIGN_TO_VIDEO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .align_to_video => "ALIGN_TO_VIDEO",
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
