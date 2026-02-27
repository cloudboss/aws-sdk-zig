/// A structure that contains information about a canary run.
pub const CanaryRunConfigOutput = struct {
    /// Displays whether this canary run used active X-Ray tracing.
    active_tracing: ?bool,

    /// Specifies the amount of ephemeral storage (in MB) to allocate for the canary
    /// run during execution. This temporary storage is used for storing canary run
    /// artifacts (which are uploaded to an Amazon S3 bucket at the end of the run),
    /// and any canary browser operations. This temporary storage is cleared after
    /// the run is completed. Default storage value is 1024 MB.
    ephemeral_storage: ?i32,

    /// The maximum amount of memory available to the canary while it is running, in
    /// MB. This value
    /// must be a multiple of 64.
    memory_in_mb: ?i32,

    /// How long the canary is allowed to run before it must stop.
    timeout_in_seconds: ?i32,

    pub const json_field_names = .{
        .active_tracing = "ActiveTracing",
        .ephemeral_storage = "EphemeralStorage",
        .memory_in_mb = "MemoryInMB",
        .timeout_in_seconds = "TimeoutInSeconds",
    };
};
