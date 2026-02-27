/// H265 Color Metadata
pub const H265ColorMetadata = enum {
    ignore,
    insert,

    pub const json_field_names = .{
        .ignore = "IGNORE",
        .insert = "INSERT",
    };
};
