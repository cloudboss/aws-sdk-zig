/// Provides information that describes the configuration of the recommended
/// target engine
/// on Amazon RDS.
pub const RdsConfiguration = struct {
    /// Describes the deployment option for the recommended Amazon RDS DB instance.
    /// The deployment
    /// options include Multi-AZ and Single-AZ deployments. Valid values include
    /// `"MULTI_AZ"` and `"SINGLE_AZ"`.
    deployment_option: ?[]const u8 = null,

    /// Describes the recommended target Amazon RDS engine edition.
    engine_edition: ?[]const u8 = null,

    /// Describes the recommended target Amazon RDS engine version.
    engine_version: ?[]const u8 = null,

    /// Describes the memory on the recommended Amazon RDS DB instance that meets
    /// your
    /// requirements.
    instance_memory: ?f64 = null,

    /// Describes the recommended target Amazon RDS instance type.
    instance_type: ?[]const u8 = null,

    /// Describes the number of virtual CPUs (vCPU) on the recommended Amazon RDS DB
    /// instance that
    /// meets your requirements.
    instance_vcpu: ?f64 = null,

    /// Describes the number of I/O operations completed each second (IOPS) on the
    /// recommended
    /// Amazon RDS DB instance that meets your requirements.
    storage_iops: ?i32 = null,

    /// Describes the storage size of the recommended Amazon RDS DB instance that
    /// meets your
    /// requirements.
    storage_size: ?i32 = null,

    /// Describes the storage type of the recommended Amazon RDS DB instance that
    /// meets your
    /// requirements.
    ///
    /// Amazon RDS provides three storage types: General Purpose SSD (also known as
    /// gp2 and gp3),
    /// Provisioned IOPS SSD (also known as io1), and magnetic (also known as
    /// standard).
    storage_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_option = "DeploymentOption",
        .engine_edition = "EngineEdition",
        .engine_version = "EngineVersion",
        .instance_memory = "InstanceMemory",
        .instance_type = "InstanceType",
        .instance_vcpu = "InstanceVcpu",
        .storage_iops = "StorageIops",
        .storage_size = "StorageSize",
        .storage_type = "StorageType",
    };
};
