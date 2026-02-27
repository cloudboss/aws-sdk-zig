pub const ExceptionResourceType = enum {
    user,
    group,
    namespace,
    account_settings,
    iampolicy_assignment,
    data_source,
    data_set,
    vpc_connection,
    ingestion,

    pub const json_field_names = .{
        .user = "USER",
        .group = "GROUP",
        .namespace = "NAMESPACE",
        .account_settings = "ACCOUNT_SETTINGS",
        .iampolicy_assignment = "IAMPOLICY_ASSIGNMENT",
        .data_source = "DATA_SOURCE",
        .data_set = "DATA_SET",
        .vpc_connection = "VPC_CONNECTION",
        .ingestion = "INGESTION",
    };
};
