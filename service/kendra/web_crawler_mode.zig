pub const WebCrawlerMode = enum {
    host_only,
    subdomains,
    everything,

    pub const json_field_names = .{
        .host_only = "HOST_ONLY",
        .subdomains = "SUBDOMAINS",
        .everything = "EVERYTHING",
    };
};
