/// When enabled, include 'clap' atom if appropriate for the video output
/// settings.
pub const MovClapAtom = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };
};
