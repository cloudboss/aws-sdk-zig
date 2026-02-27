/// Choose Insert for this setting to include color metadata in this output.
/// Choose Ignore to exclude color metadata from this output. If you don't
/// specify a value, the service sets this to Insert by default.
pub const ColorMetadata = enum {
    ignore,
    insert,

    pub const json_field_names = .{
        .ignore = "IGNORE",
        .insert = "INSERT",
    };
};
