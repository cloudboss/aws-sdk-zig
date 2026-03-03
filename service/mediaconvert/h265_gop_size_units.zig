const std = @import("std");

/// Specify how the transcoder determines GOP size for this output. We recommend
/// that you have the transcoder automatically choose this value for you based
/// on characteristics of your input video. To enable this automatic behavior,
/// choose Auto and and leave GOP size blank. By default, if you don't specify
/// GOP mode control, MediaConvert will use automatic behavior. If your output
/// group specifies HLS, DASH, or CMAF, set GOP mode control to Auto and leave
/// GOP size blank in each output in your output group. To explicitly specify
/// the GOP length, choose Specified, frames or Specified, seconds and then
/// provide the GOP length in the related setting GOP size.
pub const H265GopSizeUnits = enum {
    frames,
    seconds,
    auto,

    pub const json_field_names = .{
        .frames = "FRAMES",
        .seconds = "SECONDS",
        .auto = "AUTO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .frames => "FRAMES",
            .seconds => "SECONDS",
            .auto => "AUTO",
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
