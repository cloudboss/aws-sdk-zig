pub const RelationalDatabaseSourceType = enum {
    rds_http_endpoint,

    pub const json_field_names = .{
        .rds_http_endpoint = "RDS_HTTP_ENDPOINT",
    };
};
