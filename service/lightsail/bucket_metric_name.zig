pub const BucketMetricName = enum {
    bucket_size_bytes,
    number_of_objects,

    pub const json_field_names = .{
        .bucket_size_bytes = "BucketSizeBytes",
        .number_of_objects = "NumberOfObjects",
    };
};
