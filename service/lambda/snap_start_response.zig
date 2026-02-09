const SnapStartApplyOn = @import("snap_start_apply_on.zig").SnapStartApplyOn;
const SnapStartOptimizationStatus = @import("snap_start_optimization_status.zig").SnapStartOptimizationStatus;

/// The function's
/// [SnapStart](https://docs.aws.amazon.com/lambda/latest/dg/snapstart.html)
/// setting.
pub const SnapStartResponse = struct {
    /// When set to `PublishedVersions`, Lambda creates a snapshot of the execution
    /// environment when you publish a function version.
    apply_on: ?SnapStartApplyOn,

    /// When you provide a [qualified Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/lambda/latest/dg/configuration-versions.html#versioning-versions-using), this response element indicates whether SnapStart is activated for the specified function version.
    optimization_status: ?SnapStartOptimizationStatus,
};
