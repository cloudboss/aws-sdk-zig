pub const SalesforceDataTransferApi = enum {
    automatic,
    bulkv2,
    rest_sync,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .bulkv2 = "BULKV2",
        .rest_sync = "REST_SYNC",
    };
};
