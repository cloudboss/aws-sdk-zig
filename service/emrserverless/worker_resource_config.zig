/// The cumulative configuration requirements for every worker instance of the
/// worker type.
pub const WorkerResourceConfig = struct {
    /// The CPU requirements for every worker instance of the worker type.
    cpu: []const u8,

    /// The disk requirements for every worker instance of the worker type.
    disk: ?[]const u8,

    /// The disk type for every worker instance of the work type. Shuffle optimized
    /// disks have higher performance characteristics and are better for shuffle
    /// heavy workloads. Default is `STANDARD`.
    disk_type: ?[]const u8,

    /// The memory requirements for every worker instance of the worker type.
    memory: []const u8,

    pub const json_field_names = .{
        .cpu = "cpu",
        .disk = "disk",
        .disk_type = "diskType",
        .memory = "memory",
    };
};
