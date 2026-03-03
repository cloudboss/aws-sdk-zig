/// Describes the properties of a Dedicated Host.
pub const HostProperties = struct {
    /// The number of cores on the Dedicated Host.
    cores: ?i32 = null,

    /// The instance family supported by the Dedicated Host. For example,
    /// `m5`.
    instance_family: ?[]const u8 = null,

    /// The instance type supported by the Dedicated Host. For example, `m5.large`.
    /// If the host supports multiple instance types, no **instanceType** is
    /// returned.
    instance_type: ?[]const u8 = null,

    /// The number of sockets on the Dedicated Host.
    sockets: ?i32 = null,

    /// The total number of vCPUs on the Dedicated Host.
    total_v_cpus: ?i32 = null,
};
