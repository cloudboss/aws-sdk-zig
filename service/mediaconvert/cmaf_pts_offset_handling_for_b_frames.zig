const std = @import("std");

/// Use this setting only when your output video stream has B-frames, which
/// causes the initial presentation time stamp (PTS) to be offset from the
/// initial decode time stamp (DTS). Specify how MediaConvert handles PTS when
/// writing time stamps in output DASH manifests. Choose Match initial PTS when
/// you want MediaConvert to use the initial PTS as the first time stamp in the
/// manifest. Choose Zero-based to have MediaConvert ignore the initial PTS in
/// the video stream and instead write the initial time stamp as zero in the
/// manifest. For outputs that don't have B-frames, the time stamps in your DASH
/// manifests start at zero regardless of your choice here.
pub const CmafPtsOffsetHandlingForBFrames = enum {
    zero_based,
    match_initial_pts,

    pub const json_field_names = .{
        .zero_based = "ZERO_BASED",
        .match_initial_pts = "MATCH_INITIAL_PTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .zero_based => "ZERO_BASED",
            .match_initial_pts => "MATCH_INITIAL_PTS",
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
