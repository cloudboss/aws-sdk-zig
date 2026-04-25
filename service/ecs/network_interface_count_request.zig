/// The minimum and maximum number of network interfaces for instance type
/// selection. This is useful for workloads that require multiple network
/// interfaces.
pub const NetworkInterfaceCountRequest = struct {
    /// The maximum number of network interfaces. Instance types that support more
    /// network interfaces are excluded from selection.
    max: ?i32 = null,

    /// The minimum number of network interfaces. Instance types that support fewer
    /// network interfaces are excluded from selection.
    min: ?i32 = null,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
