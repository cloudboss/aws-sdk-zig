pub const ListGroupingStatusesFilterName = enum {
    status,
    resource_arn,

    pub const json_field_names = .{
        .status = "Status",
        .resource_arn = "ResourceArn",
    };
};
