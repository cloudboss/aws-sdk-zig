/// The runtime platform that Amazon ECS applies to a service revision. This
/// value overrides the runtime platform specified in the task definition. You
/// can't set this value.
pub const RuntimePlatformOverride = struct {
    /// The CPU architecture that tasks in this service revision run on. This value
    /// might differ from the architecture declared in the task definition—for
    /// example, when Amazon ECS detects an architecture mismatch during an Amazon
    /// ECS Express deployment and runs tasks on a different architecture. You can't
    /// set this value.
    ///
    /// Valid values:
    ///
    /// * `X86_64` - The x86 64-bit architecture.
    /// * `ARM64` - The 64-bit ARM architecture.
    cpu_architecture: ?[]const u8 = null,

    pub const json_field_names = .{
        .cpu_architecture = "cpuArchitecture",
    };
};
