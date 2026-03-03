/// Specifies the CPU options for an Amazon EC2 instance. For more information,
/// see
/// [Optimize CPU
/// options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-optimize-cpu.html) in the *Amazon Elastic Compute Cloud User Guide*.
pub const AwsEc2LaunchTemplateDataCpuOptionsDetails = struct {
    /// The number of CPU cores for the instance.
    core_count: ?i32 = null,

    /// The number of threads per CPU core. A value of `1` disables multithreading
    /// for the instance,
    /// The default value is `2`.
    threads_per_core: ?i32 = null,

    pub const json_field_names = .{
        .core_count = "CoreCount",
        .threads_per_core = "ThreadsPerCore",
    };
};
