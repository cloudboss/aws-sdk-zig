/// The supported properties for a PO type data set.
pub const PoDetailAttributes = struct {
    /// The character set encoding of the data set.
    encoding: []const u8,

    /// The format of the data set records.
    format: []const u8,

    pub const json_field_names = .{
        .encoding = "encoding",
        .format = "format",
    };
};
