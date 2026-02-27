/// An array of objects representing the destination for a replication rule.
pub const ReplicationDestination = struct {
    /// The Region to replicate to.
    region: []const u8,

    /// The Amazon Web Services account ID of the Amazon ECR private registry to
    /// replicate to. When configuring
    /// cross-Region replication within your own registry, specify your own account
    /// ID.
    registry_id: []const u8,

    pub const json_field_names = .{
        .region = "region",
        .registry_id = "registryId",
    };
};
