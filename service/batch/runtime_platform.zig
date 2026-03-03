/// An object that represents the compute environment architecture for Batch
/// jobs on
/// Fargate.
pub const RuntimePlatform = struct {
    /// The vCPU architecture. The default value is `X86_64`. Valid values are
    /// `X86_64` and `ARM64`.
    ///
    /// This parameter must be set to `X86_64` for Windows containers.
    ///
    /// Fargate Spot is not supported on Windows-based containers on
    /// Fargate. A job queue will be blocked if a Windows job is
    /// submitted to a job queue with only Fargate Spot compute environments.
    /// However, you can attach
    /// both `FARGATE` and `FARGATE_SPOT` compute environments to the same job
    /// queue.
    cpu_architecture: ?[]const u8 = null,

    /// The operating system for the compute environment. Valid values are:
    /// `LINUX` (default), `WINDOWS_SERVER_2019_CORE`,
    /// `WINDOWS_SERVER_2019_FULL`, `WINDOWS_SERVER_2022_CORE`, and
    /// `WINDOWS_SERVER_2022_FULL`.
    ///
    /// The following parameters can’t be set for Windows containers:
    /// `linuxParameters`,
    /// `privileged`, `user`, `ulimits`,
    /// `readonlyRootFilesystem`, and `efsVolumeConfiguration`.
    ///
    /// The Batch Scheduler checks the compute environments that are attached to the
    /// job queue before
    /// registering a task definition with Fargate. In this scenario, the job queue
    /// is where the job is
    /// submitted. If the job requires a Windows container and the first compute
    /// environment is `LINUX`,
    /// the compute environment is skipped and the next compute environment is
    /// checked until a Windows-based
    /// compute environment is found.
    ///
    /// Fargate Spot is not supported on Windows-based containers on Fargate.
    /// A job queue will be blocked if a Windows job is submitted to a job
    /// queue with only Fargate Spot compute environments. However, you can attach
    /// both `FARGATE` and
    /// `FARGATE_SPOT` compute environments to the same job queue.
    operating_system_family: ?[]const u8 = null,

    pub const json_field_names = .{
        .cpu_architecture = "cpuArchitecture",
        .operating_system_family = "operatingSystemFamily",
    };
};
