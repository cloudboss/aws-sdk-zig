const OnDemandThroughput = @import("on_demand_throughput.zig").OnDemandThroughput;
const ProvisionedThroughput = @import("provisioned_throughput.zig").ProvisionedThroughput;
const WarmThroughput = @import("warm_throughput.zig").WarmThroughput;

/// Represents the new provisioned throughput settings to be applied to a global
/// secondary
/// index.
pub const UpdateGlobalSecondaryIndexAction = struct {
    /// The name of the global secondary index to be updated.
    index_name: []const u8,

    /// Updates the maximum number of read and write units for the specified global
    /// secondary
    /// index. If you use this parameter, you must specify `MaxReadRequestUnits`,
    /// `MaxWriteRequestUnits`, or both.
    on_demand_throughput: ?OnDemandThroughput,

    /// Represents the provisioned throughput settings for the specified global
    /// secondary
    /// index.
    ///
    /// For current minimum and maximum provisioned throughput values, see [Service,
    /// Account, and Table
    /// Quotas](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Limits.html) in the *Amazon DynamoDB Developer
    /// Guide*.
    provisioned_throughput: ?ProvisionedThroughput,

    /// Represents the warm throughput value of the new provisioned throughput
    /// settings to be
    /// applied to a global secondary index.
    warm_throughput: ?WarmThroughput,
};
