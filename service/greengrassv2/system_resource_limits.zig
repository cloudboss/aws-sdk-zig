/// Contains information about system resource limits that the IoT Greengrass
/// Core software applies to a
/// component's processes. For more information, see [Configure system resource
/// limits for
/// components](https://docs.aws.amazon.com/greengrass/v2/developerguide/configure-greengrass-core-v2.html#configure-component-system-resource-limits).
pub const SystemResourceLimits = struct {
    /// The maximum amount of CPU time that a component's processes can use on the
    /// core device. A
    /// core device's total CPU time is equivalent to the device's number of CPU
    /// cores. For example,
    /// on a core device with 4 CPU cores, you can set this value to `2` to limit
    /// the
    /// component's processes to 50 percent usage of each CPU core. On a device with
    /// 1 CPU core, you
    /// can set this value to `0.25` to limit the component's processes to 25
    /// percent usage
    /// of the CPU. If you set this value to a number greater than the number of CPU
    /// cores, the IoT Greengrass Core
    /// software doesn't limit the component's CPU usage.
    cpus: f64 = 0,

    /// The maximum amount of RAM, expressed in kilobytes, that a component's
    /// processes can use on
    /// the core device.
    memory: i64 = 0,

    pub const json_field_names = .{
        .cpus = "cpus",
        .memory = "memory",
    };
};
