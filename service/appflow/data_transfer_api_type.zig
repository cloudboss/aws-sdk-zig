pub const DataTransferApiType = enum {
    sync,
    @"async",
    automatic,

    pub const json_field_names = .{
        .sync = "SYNC",
        .@"async" = "ASYNC",
        .automatic = "AUTOMATIC",
    };
};
