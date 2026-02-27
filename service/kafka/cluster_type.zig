/// The type of cluster.
pub const ClusterType = enum {
    provisioned,
    serverless,

    pub const json_field_names = .{
        .provisioned = "PROVISIONED",
        .serverless = "SERVERLESS",
    };
};
