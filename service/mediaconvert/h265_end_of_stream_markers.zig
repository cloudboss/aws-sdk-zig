/// Optionally include or suppress markers at the end of your output that signal
/// the end of the video stream. To include end of stream markers: Leave blank
/// or keep the default value, Include. To not include end of stream markers:
/// Choose Suppress. This is useful when your output will be inserted into
/// another stream.
pub const H265EndOfStreamMarkers = enum {
    include,
    suppress,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .suppress = "SUPPRESS",
    };
};
