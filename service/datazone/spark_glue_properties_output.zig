const SparkGlueArgs = @import("spark_glue_args.zig").SparkGlueArgs;

/// The Spark Amazon Web Services Glue properties.
pub const SparkGluePropertiesOutput = struct {
    /// The additional args in the Spark Amazon Web Services Glue properties.
    additional_args: ?SparkGlueArgs,

    /// The Amazon Web Services Glue connection name in the Spark Amazon Web
    /// Services Glue properties.
    glue_connection_name: ?[]const u8,

    /// The Amazon Web Services Glue version in the Spark Amazon Web Services Glue
    /// properties.
    glue_version: ?[]const u8,

    /// The idle timeout in the Spark Amazon Web Services Glue properties.
    idle_timeout: ?i32,

    /// The Java virtual env in the Spark Amazon Web Services Glue properties.
    java_virtual_env: ?[]const u8,

    /// The number of workers in the Spark Amazon Web Services Glue properties.
    number_of_workers: ?i32,

    /// The Python virtual env in the Spark Amazon Web Services Glue properties.
    python_virtual_env: ?[]const u8,

    /// The worker type in the Spark Amazon Web Services Glue properties.
    worker_type: ?[]const u8,

    pub const json_field_names = .{
        .additional_args = "additionalArgs",
        .glue_connection_name = "glueConnectionName",
        .glue_version = "glueVersion",
        .idle_timeout = "idleTimeout",
        .java_virtual_env = "javaVirtualEnv",
        .number_of_workers = "numberOfWorkers",
        .python_virtual_env = "pythonVirtualEnv",
        .worker_type = "workerType",
    };
};
