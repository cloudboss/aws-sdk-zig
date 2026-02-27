/// Describes the powers that can be specified for an Amazon Lightsail container
/// service.
///
/// The power specifies the amount of RAM, the number of vCPUs, and the base
/// price of the
/// container service.
pub const ContainerServicePower = struct {
    /// The number of vCPUs included in the power.
    cpu_count: ?f32,

    /// A Boolean value indicating whether the power is active and can be specified
    /// for container
    /// services.
    is_active: ?bool,

    /// The friendly name of the power (`nano`).
    name: ?[]const u8,

    /// The ID of the power (`nano-1`).
    power_id: ?[]const u8,

    /// The monthly price of the power in USD.
    price: ?f32,

    /// The amount of RAM (in GB) of the power.
    ram_size_in_gb: ?f32,

    pub const json_field_names = .{
        .cpu_count = "cpuCount",
        .is_active = "isActive",
        .name = "name",
        .power_id = "powerId",
        .price = "price",
        .ram_size_in_gb = "ramSizeInGb",
    };
};
