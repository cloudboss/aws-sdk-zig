/// A new object to add to the governed table.
pub const AddObjectInput = struct {
    /// The Amazon S3 ETag of the object. Returned by `GetTableObjects` for
    /// validation and used to identify changes to the underlying data.
    e_tag: []const u8,

    /// A list of partition values for the object. A value must be specified for
    /// each partition key associated with the table.
    ///
    /// The supported data types are integer, long, date(yyyy-MM-dd),
    /// timestamp(yyyy-MM-dd HH:mm:ssXXX or yyyy-MM-dd HH:mm:ss"), string and
    /// decimal.
    partition_values: ?[]const []const u8,

    /// The size of the Amazon S3 object in bytes.
    size: i64 = 0,

    /// The Amazon S3 location of the object.
    uri: []const u8,

    pub const json_field_names = .{
        .e_tag = "ETag",
        .partition_values = "PartitionValues",
        .size = "Size",
        .uri = "Uri",
    };
};
