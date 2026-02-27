/// Specifies if the lifecycle policy should apply actions to selected
/// resources.
pub const ResourceStateUpdateIncludeResources = struct {
    /// Specifies whether the lifecycle action should apply to distributed AMIs
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
