/// H264 Color Metadata
pub const H264ColorMetadata = enum {
    ignore,
    insert,

    pub const json_field_names = .{
        .ignore = "IGNORE",
        .insert = "INSERT",
    };
};
