/// Provides information that describes the requirements to the target engine on
/// Amazon RDS.
pub const RdsRequirements = struct {
    /// The required deployment option for the Amazon RDS DB instance. Valid values
    /// include
    /// `"MULTI_AZ"` for Multi-AZ deployments and `"SINGLE_AZ"` for
    /// Single-AZ deployments.
    deployment_option: ?[]const u8,

    /// The required target Amazon RDS engine edition.
    engine_edition: ?[]const u8,

    /// The required target Amazon RDS engine version.
    engine_version: ?[]const u8,

    /// The required memory on the Amazon RDS DB instance.
    instance_memory: ?f64,

    /// The required number of virtual CPUs (vCPU) on the Amazon RDS DB instance.
    instance_vcpu: ?f64,

    /// The required number of I/O operations completed each second (IOPS) on your
    /// Amazon RDS DB
    /// instance.
    storage_iops: ?i32,

    /// The required Amazon RDS DB instance storage size.
    storage_size: ?i32,

    pub const json_field_names = .{
        .deployment_option = "DeploymentOption",
        .engine_edition = "EngineEdition",
        .engine_version = "EngineVersion",
        .instance_memory = "InstanceMemory",
        .instance_vcpu = "InstanceVcpu",
        .storage_iops = "StorageIops",
        .storage_size = "StorageSize",
    };
};
