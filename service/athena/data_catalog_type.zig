pub const DataCatalogType = enum {
    lambda,
    glue,
    hive,
    federated,

    pub const json_field_names = .{
        .lambda = "LAMBDA",
        .glue = "GLUE",
        .hive = "HIVE",
        .federated = "FEDERATED",
    };
};
