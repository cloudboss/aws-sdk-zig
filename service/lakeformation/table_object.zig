/// Specifies the details of a governed table.
pub const TableObject = struct {
    /// The Amazon S3 ETag of the object. Returned by `GetTableObjects` for
    /// validation and used to identify changes to the underlying data.
    e_tag: ?[]const u8 = null,

    /// The size of the Amazon S3 object in bytes.
    size: i64 = 0,

    /// The Amazon S3 location of the object.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .e_tag = "ETag",
        .size = "Size",
        .uri = "Uri",
    };
};
