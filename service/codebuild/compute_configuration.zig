const MachineType = @import("machine_type.zig").MachineType;

/// Contains compute attributes. These attributes only need be specified when
/// your project's or fleet's `computeType` is set to `ATTRIBUTE_BASED_COMPUTE`
/// or `CUSTOM_INSTANCE_TYPE`.
pub const ComputeConfiguration = struct {
    /// The amount of disk space of the instance type included in your fleet.
    disk: ?i64 = null,

    /// The EC2 instance type to be launched in your fleet.
    instance_type: ?[]const u8 = null,

    /// The machine type of the instance type included in your fleet.
    machine_type: ?MachineType = null,

    /// The amount of memory of the instance type included in your fleet.
    memory: ?i64 = null,

    /// The number of vCPUs of the instance type included in your fleet.
    v_cpu: ?i64 = null,

    pub const json_field_names = .{
        .disk = "disk",
        .instance_type = "instanceType",
        .machine_type = "machineType",
        .memory = "memory",
        .v_cpu = "vCpu",
    };
};
