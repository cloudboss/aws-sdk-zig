/// Inserts a free-space box immediately after the moov box.
pub const Mp4FreeSpaceBox = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };
};
