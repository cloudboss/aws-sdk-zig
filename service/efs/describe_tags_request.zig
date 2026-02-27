pub const DescribeTagsRequest = struct {
    /// The ID of the file system whose tag set you want to retrieve.
    file_system_id: []const u8,

    /// (Optional) An opaque pagination token returned from a previous
    /// `DescribeTags` operation (String). If present, it specifies to continue the
    /// list
    /// from where the previous call left off.
    marker: ?[]const u8,

    /// (Optional) The maximum number of file system tags to return in the response.
    /// Currently,
    /// this number is automatically set to
    /// 100, and other values are ignored. The response is paginated at 100 per page
    /// if you have more than 100 tags.
    max_items: ?i32,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .marker = "Marker",
        .max_items = "MaxItems",
    };
};
