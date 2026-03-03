const std = @import("std");

/// If you are using the console, use the Framerate setting to specify the frame
/// rate for this output. If you want to keep the same frame rate as the input
/// video, choose Follow source. If you want to do frame rate conversion, choose
/// a frame rate from the dropdown list or choose Custom. The framerates shown
/// in the dropdown list are decimal approximations of fractions. If you choose
/// Custom, specify your frame rate as a fraction. If you are creating your
/// transcoding job specification as a JSON file without the console, use
/// FramerateControl to specify which value the service uses for the frame rate
/// for this output. Choose INITIALIZE_FROM_SOURCE if you want the service to
/// use the frame rate from the input. Choose SPECIFIED if you want the service
/// to use the frame rate you specify in the settings FramerateNumerator and
/// FramerateDenominator.
pub const GifFramerateControl = enum {
    initialize_from_source,
    specified,

    pub const json_field_names = .{
        .initialize_from_source = "INITIALIZE_FROM_SOURCE",
        .specified = "SPECIFIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initialize_from_source => "INITIALIZE_FROM_SOURCE",
            .specified => "SPECIFIED",
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
