pub const ResourceDataSyncS3Format = enum {
    json_serde,

    pub const json_field_names = .{
        .json_serde = "JSON_SERDE",
    };
};
