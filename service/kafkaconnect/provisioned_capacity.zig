/// Details about a connector's provisioned capacity.
pub const ProvisionedCapacity = struct {
    /// The number of microcontroller units (MCUs) allocated to each connector
    /// worker. The valid values are 1,2,4,8.
    mcu_count: i32 = 0,

    /// The number of workers that are allocated to the connector.
    worker_count: i32 = 0,

    pub const json_field_names = .{
        .mcu_count = "mcuCount",
        .worker_count = "workerCount",
    };
};
