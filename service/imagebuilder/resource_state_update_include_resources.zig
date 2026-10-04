/// Specifies which underlying resources the resource state update applies to,
/// in addition to the Image Builder image resource itself: distributed AMIs and
/// their
/// snapshots for AMI images, or distributed container images for container
/// images.
pub const ResourceStateUpdateIncludeResources = struct {
    /// Specifies whether the lifecycle action should apply to distributed AMIs.
    amis: bool = false,

    /// Specifies whether the lifecycle action should apply to distributed
    /// containers.
    containers: bool = false,

    /// Specifies whether the lifecycle action should apply to snapshots associated
    /// with distributed AMIs.
    snapshots: bool = false,

    pub const json_field_names = .{
        .amis = "amis",
        .containers = "containers",
        .snapshots = "snapshots",
    };
};
