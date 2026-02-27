/// Specifies the placement details for the node in the SageMaker HyperPod
/// cluster, including the Availability Zone and the unique identifier (ID) of
/// the Availability Zone.
pub const ClusterInstancePlacement = struct {
    /// The Availability Zone where the node in the SageMaker HyperPod cluster is
    /// launched.
    availability_zone: ?[]const u8,

    /// The unique identifier (ID) of the Availability Zone where the node in the
    /// SageMaker HyperPod cluster is launched.
    availability_zone_id: ?[]const u8,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .availability_zone_id = "AvailabilityZoneId",
    };
};
