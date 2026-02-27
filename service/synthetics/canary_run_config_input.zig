const aws = @import("aws");

/// A structure that contains input information for a canary run.
pub const CanaryRunConfigInput = struct {
    /// Specifies whether this canary is to use active X-Ray tracing when it runs.
    /// Active tracing
    /// enables
    /// this canary run to be displayed in the ServiceLens and X-Ray service maps
    /// even if the canary does
    /// not hit an endpoint that has X-Ray tracing enabled. Using X-Ray tracing
    /// incurs charges.
    /// For more information, see [
    /// Canaries and X-Ray
    /// tracing](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_tracing.html).
    ///
    /// You can enable active tracing only for canaries that use version
    /// `syn-nodejs-2.0`
    /// or later for their canary runtime.
    active_tracing: ?bool,

    /// Specifies the keys and values to use for any environment variables
    /// used in the canary script. Use the following format:
    ///
    /// { "key1" : "value1", "key2" : "value2", ...}
    ///
    /// Keys must start with a letter and be at least two characters. The total size
    /// of your environment variables cannot exceed 4 KB. You can't specify any
    /// Lambda
    /// reserved environment variables as the keys for your environment variables.
    /// For
    /// more information about reserved keys, see [
    /// Runtime environment
    /// variables](https://docs.aws.amazon.com/lambda/latest/dg/configuration-envvars.html#configuration-envvars-runtime).
    ///
    /// Environment variable keys and values are encrypted at rest using Amazon Web
    /// Services owned KMS keys. However, the environment variables
    /// are not encrypted on the client side. Do not store sensitive information
    /// in them.
    environment_variables: ?[]const aws.map.StringMapEntry,

    /// Specifies the amount of ephemeral storage (in MB) to allocate for the canary
    /// run during execution. This temporary storage is used for storing canary run
    /// artifacts (which are uploaded to an Amazon S3 bucket at the end of the run),
    /// and any canary browser operations. This temporary storage is cleared after
    /// the run is completed. Default storage value is 1024 MB.
    ephemeral_storage: ?i32,

    /// The maximum amount of memory available to the canary while it is running, in
    /// MB. This value must be a multiple of 64.
    memory_in_mb: ?i32,

    /// How long the canary is allowed to run before it must stop. You can't set
    /// this time to be longer
    /// than the frequency of the runs of this canary.
    ///
    /// If you omit this field, the
    /// frequency of the canary is used as this value, up to a maximum of 14
    /// minutes.
    timeout_in_seconds: ?i32,

    pub const json_field_names = .{
        .active_tracing = "ActiveTracing",
        .environment_variables = "EnvironmentVariables",
        .ephemeral_storage = "EphemeralStorage",
        .memory_in_mb = "MemoryInMB",
        .timeout_in_seconds = "TimeoutInSeconds",
    };
};
