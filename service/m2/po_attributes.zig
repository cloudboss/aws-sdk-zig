/// The supported properties for a PO type data set.
pub const PoAttributes = struct {
    /// The character set encoding of the data set.
    encoding: ?[]const u8 = null,

    /// The format of the data set records.
    format: []const u8,

    /// An array containing one or more filename extensions, allowing you to specify
    /// which files
    /// to be included as PDS member.
    member_file_extensions: []const []const u8,

    pub const json_field_names = .{
        .encoding = "encoding",
        .format = "format",
        .member_file_extensions = "memberFileExtensions",
    };
};
