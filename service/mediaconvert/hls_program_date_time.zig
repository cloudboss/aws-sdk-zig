/// Includes or excludes EXT-X-PROGRAM-DATE-TIME tag in .m3u8 manifest files.
/// The value is calculated as follows: either the program date and time are
/// initialized using the input timecode source, or the time is initialized
/// using the input timecode source and the date is initialized using the
/// timestamp_offset.
pub const HlsProgramDateTime = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };
};
