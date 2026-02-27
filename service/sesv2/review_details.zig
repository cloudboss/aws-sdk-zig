const ReviewStatus = @import("review_status.zig").ReviewStatus;

/// An object that contains information about your account details review.
pub const ReviewDetails = struct {
    /// The associated support center case ID (if any).
    case_id: ?[]const u8,

    /// The status of the latest review of your account. The status can be one of
    /// the
    /// following:
    ///
    /// * `PENDING` – We have received your appeal and are in the
    /// process of reviewing it.
    ///
    /// * `GRANTED` – Your appeal has been reviewed and your production
    /// access has been granted.
    ///
    /// * `DENIED` – Your appeal has been reviewed and your production
    /// access has been denied.
    ///
    /// * `FAILED` – An internal error occurred and we didn't receive
    /// your appeal. You can submit your appeal again.
    status: ?ReviewStatus,

    pub const json_field_names = .{
        .case_id = "CaseId",
        .status = "Status",
    };
};
