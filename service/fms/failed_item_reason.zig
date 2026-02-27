pub const FailedItemReason = enum {
    not_valid_arn,
    not_valid_partition,
    not_valid_region,
    not_valid_service,
    not_valid_resource_type,
    not_valid_account_id,

    pub const json_field_names = .{
        .not_valid_arn = "NotValidArn",
        .not_valid_partition = "NotValidPartition",
        .not_valid_region = "NotValidRegion",
        .not_valid_service = "NotValidService",
        .not_valid_resource_type = "NotValidResourceType",
        .not_valid_account_id = "NotValidAccountId",
    };
};
