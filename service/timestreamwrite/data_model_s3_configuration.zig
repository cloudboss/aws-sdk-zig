pub const DataModelS3Configuration = struct {
    bucket_name: ?[]const u8,

    object_key: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .object_key = "ObjectKey",
    };
};
