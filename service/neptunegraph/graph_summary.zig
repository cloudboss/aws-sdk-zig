const GraphStatus = @import("graph_status.zig").GraphStatus;

/// Summary details about a graph.
pub const GraphSummary = struct {
    /// The ARN associated with the graph.
    arn: []const u8,

    /// If `true`, deletion protection is enabled for the graph.
    deletion_protection: ?bool = null,

    /// The graph endpoint.
    endpoint: ?[]const u8 = null,

    /// The unique identifier of the graph.
    id: []const u8,

    /// The ID of the KMS key used to encrypt and decrypt graph data.
    kms_key_identifier: ?[]const u8 = null,

    /// The name of the graph.
    name: []const u8,

    /// The number of memory-optimized Neptune Capacity Units (m-NCUs) allocated to
    /// the graph.
    provisioned_memory: ?i32 = null,

    /// If `true`, the graph has a public endpoint, otherwise not.
    public_connectivity: ?bool = null,

    /// The number of replicas for the graph.
    replica_count: ?i32 = null,

    /// The status of the graph.
    status: ?GraphStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .deletion_protection = "deletionProtection",
        .endpoint = "endpoint",
        .id = "id",
        .kms_key_identifier = "kmsKeyIdentifier",
        .name = "name",
        .provisioned_memory = "provisionedMemory",
        .public_connectivity = "publicConnectivity",
        .replica_count = "replicaCount",
        .status = "status",
    };
};
