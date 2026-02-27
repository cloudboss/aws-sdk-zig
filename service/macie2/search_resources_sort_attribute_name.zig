/// The property to sort the query results by. Valid values are:
pub const SearchResourcesSortAttributeName = enum {
    account_id,
    resource_name,
    s3_classifiable_object_count,
    s3_classifiable_size_in_bytes,

    pub const json_field_names = .{
        .account_id = "ACCOUNT_ID",
        .resource_name = "RESOURCE_NAME",
        .s3_classifiable_object_count = "S3_CLASSIFIABLE_OBJECT_COUNT",
        .s3_classifiable_size_in_bytes = "S3_CLASSIFIABLE_SIZE_IN_BYTES",
    };
};
