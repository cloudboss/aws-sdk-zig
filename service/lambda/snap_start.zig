const SnapStartApplyOn = @import("snap_start_apply_on.zig").SnapStartApplyOn;

/// The function's [Lambda
/// SnapStart](https://docs.aws.amazon.com/lambda/latest/dg/snapstart.html)
/// setting. Set `ApplyOn` to `PublishedVersions` to create a snapshot of the
/// initialized execution environment when you publish a function version.
pub const SnapStart = struct {
    /// Set to `PublishedVersions` to create a snapshot of the initialized execution
    /// environment when you publish a function version.
    apply_on: ?SnapStartApplyOn,
};
