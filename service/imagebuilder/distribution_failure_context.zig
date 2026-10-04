const RegionFailure = @import("region_failure.zig").RegionFailure;

/// Contains details about a failure that occurred while Image Builder
/// distributed the image
/// or applied configuration to the distributed image.
pub const DistributionFailureContext = struct {
    /// The error message for the distribution failure.
    error_message: ?[]const u8 = null,

    /// The details about the failure for each Region where the image didn't finish
    /// distribution or configuration.
    region_failures: ?[]const RegionFailure = null,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .region_failures = "regionFailures",
    };
};
