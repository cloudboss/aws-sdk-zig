/// Configuration for a capacity provider volume mounted into the AgentCore
/// Runtime. This references a persistent volume by its logical name, as defined
/// in the capacity provider's list of volumes.
pub const CapacityProviderVolumeConfiguration = struct {
    /// The mount path for the capacity provider volume inside the AgentCore
    /// Runtime. The path must be under `/mnt` with exactly one subdirectory level
    /// (for example, `/mnt/data`).
    mount_path: []const u8,

    /// The logical name of the capacity provider volume to mount. This name must
    /// match a volume that is defined in the capacity provider's list of volumes.
    volume_name: []const u8,

    pub const json_field_names = .{
        .mount_path = "mountPath",
        .volume_name = "volumeName",
    };
};
