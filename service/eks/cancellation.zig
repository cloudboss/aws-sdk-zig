const CancellationStatus = @import("cancellation_status.zig").CancellationStatus;

/// Contains information about the latest cancellation of an update to an Amazon
/// EKS cluster.
pub const Cancellation = struct {
    /// A message providing additional details about the cancellation, such as the
    /// reason for
    /// the cancellation or failure details.
    reason: ?[]const u8 = null,

    /// The current status of the cancellation. Valid values are `InProgress`,
    /// `Failed`, and `Successful`.
    status: ?CancellationStatus = null,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
