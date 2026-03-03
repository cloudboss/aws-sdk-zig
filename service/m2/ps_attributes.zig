/// The supported properties for a PS type data set.
pub const PsAttributes = struct {
    /// The character set encoding of the data set.
    encoding: ?[]const u8 = null,

    /// The format of the data set records.
    format: []const u8,

    pub const json_field_names = .{
        .encoding = "encoding",
        .format = "format",
    };
};
