const std = @import("std");

/// Specify how the value for bandwidth is determined for each video
/// Representation in your output MPD manifest. We recommend that you choose a
/// MPD manifest bandwidth type that is compatible with your downstream player
/// configuration. Max: Use the same value that you specify for Max bitrate in
/// the video output, in bits per second. Average: Use the calculated average
/// bitrate of the encoded video output, in bits per second.
pub const DashIsoMpdManifestBandwidthType = enum {
    average,
    max,

    pub const json_field_names = .{
        .average = "AVERAGE",
        .max = "MAX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .average => "AVERAGE",
            .max => "MAX",
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
