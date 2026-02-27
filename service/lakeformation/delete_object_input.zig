/// An object to delete from the governed table.
pub const DeleteObjectInput = struct {
    /// The Amazon S3 ETag of the object. Returned by `GetTableObjects` for
    /// validation and used to identify changes to the underlying data.
    e_tag: ?[]const u8,

    /// A list of partition values for the object. A value must be specified for
    /// each partition key associated with the governed table.
    partition_values: ?[]const []const u8,

    /// The Amazon S3 location of the object to delete.
    uri: []const u8,

    pub const json_field_names = .{
        .e_tag = "ETag",
        .partition_values = "PartitionValues",
        .uri = "Uri",
    };
};
