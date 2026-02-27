/// Mpeg2 Color Metadata
pub const Mpeg2ColorMetadata = enum {
    ignore,
    insert,

    pub const json_field_names = .{
        .ignore = "IGNORE",
        .insert = "INSERT",
    };
};
