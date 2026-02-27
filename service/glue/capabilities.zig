const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const ComputeEnvironment = @import("compute_environment.zig").ComputeEnvironment;
const DataOperation = @import("data_operation.zig").DataOperation;

/// Specifies the supported authentication types returned by the
/// `DescribeConnectionType` API.
pub const Capabilities = struct {
    /// A list of supported authentication types.
    supported_authentication_types: []const AuthenticationType,

    /// A list of supported compute environments.
    supported_compute_environments: []const ComputeEnvironment,

    /// A list of supported data operations.
    supported_data_operations: []const DataOperation,

    pub const json_field_names = .{
        .supported_authentication_types = "SupportedAuthenticationTypes",
        .supported_compute_environments = "SupportedComputeEnvironments",
        .supported_data_operations = "SupportedDataOperations",
    };
};
