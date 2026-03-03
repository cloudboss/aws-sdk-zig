const LambdaContainerParams = @import("lambda_container_params.zig").LambdaContainerParams;
const LambdaIsolationMode = @import("lambda_isolation_mode.zig").LambdaIsolationMode;

/// Contains parameters for a Linux process that contains an Lambda function.
pub const LambdaLinuxProcessParams = struct {
    /// The parameters for the container in which the Lambda function runs.
    container_params: ?LambdaContainerParams = null,

    /// The isolation mode for the process that contains the Lambda function. The
    /// process can run
    /// in an isolated runtime environment inside the IoT Greengrass container, or
    /// as a regular process outside
    /// any container.
    ///
    /// Default: `GreengrassContainer`
    isolation_mode: ?LambdaIsolationMode = null,

    pub const json_field_names = .{
        .container_params = "containerParams",
        .isolation_mode = "isolationMode",
    };
};
