const std = @import("std");

/// Choose the video selector type for your HLS input. Use to specify which
/// video rendition MediaConvert uses from your HLS input. To have MediaConvert
/// automatically use the highest bitrate rendition from your HLS input: Keep
/// the default value, Auto. To manually specify a rendition: Choose Stream.
/// Then enter the unique stream number in the Streams array, starting at 1,
/// corresponding to the stream order in the manifest.
pub const VideoSelectorType = enum {
    auto,
    stream,

    pub const json_field_names = .{
        .auto = "AUTO",
        .stream = "STREAM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .stream => "STREAM",
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
