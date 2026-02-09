const ProvisionedConcurrencyStatusEnum = @import("provisioned_concurrency_status_enum.zig").ProvisionedConcurrencyStatusEnum;

/// Details about the provisioned concurrency configuration for a function alias
/// or version.
pub const ProvisionedConcurrencyConfigListItem = struct {
    /// The amount of provisioned concurrency allocated. When a weighted alias is
    /// used during linear and canary deployments, this value fluctuates depending
    /// on the amount of concurrency that is provisioned for the function versions.
    allocated_provisioned_concurrent_executions: ?i32,

    /// The amount of provisioned concurrency available.
    available_provisioned_concurrent_executions: ?i32,

    /// The Amazon Resource Name (ARN) of the alias or version.
    function_arn: ?[]const u8,

    /// The date and time that a user last updated the configuration, in [ISO 8601
    /// format](https://www.iso.org/iso-8601-date-and-time-format.html).
    last_modified: ?[]const u8,

    /// The amount of provisioned concurrency requested.
    requested_provisioned_concurrent_executions: ?i32,

    /// The status of the allocation process.
    status: ?ProvisionedConcurrencyStatusEnum,

    /// For failed allocations, the reason that provisioned concurrency could not be
    /// allocated.
    status_reason: ?[]const u8,
};
