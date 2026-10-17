/// A single Amazon Simple Storage Service object to import as a notebook cell.
pub const S3File = struct {
    /// The key of the Amazon Simple Storage Service object to import.
    key: []const u8,

    pub const json_field_names = .{
        .key = "key",
    };
};
