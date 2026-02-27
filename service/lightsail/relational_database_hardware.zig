/// Describes the hardware of a database.
pub const RelationalDatabaseHardware = struct {
    /// The number of vCPUs for the database.
    cpu_count: ?i32,

    /// The size of the disk for the database.
    disk_size_in_gb: ?i32,

    /// The amount of RAM in GB for the database.
    ram_size_in_gb: ?f32,

    pub const json_field_names = .{
        .cpu_count = "cpuCount",
        .disk_size_in_gb = "diskSizeInGb",
        .ram_size_in_gb = "ramSizeInGb",
    };
};
