/// Details on the Amazon EC2 Resource.
pub const EC2ResourceDetails = struct {
    /// The hourly public On-Demand rate for the instance type.
    hourly_on_demand_rate: ?[]const u8,

    /// The type of Amazon Web Services instance.
    instance_type: ?[]const u8,

    /// The memory capacity of the Amazon Web Services instance.
    memory: ?[]const u8,

    /// The network performance capacity of the Amazon Web Services instance.
    network_performance: ?[]const u8,

    /// The platform of the Amazon Web Services instance. The platform is the
    /// specific
    /// combination of operating system, license model, and software on an instance.
    platform: ?[]const u8,

    /// The Amazon Web Services Region of the instance.
    region: ?[]const u8,

    /// The SKU of the product.
    sku: ?[]const u8,

    /// The disk storage of the Amazon Web Services instance. This doesn't include
    /// EBS
    /// storage.
    storage: ?[]const u8,

    /// The number of VCPU cores in the Amazon Web Services instance type.
    vcpu: ?[]const u8,

    pub const json_field_names = .{
        .hourly_on_demand_rate = "HourlyOnDemandRate",
        .instance_type = "InstanceType",
        .memory = "Memory",
        .network_performance = "NetworkPerformance",
        .platform = "Platform",
        .region = "Region",
        .sku = "Sku",
        .storage = "Storage",
        .vcpu = "Vcpu",
    };
};
