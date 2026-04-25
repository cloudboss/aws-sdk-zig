const aws = @import("aws");

const FrontOfQuotaShareJobSummary = @import("front_of_quota_share_job_summary.zig").FrontOfQuotaShareJobSummary;

/// An object that represents the details of the first `RUNNABLE` job in each
/// named quota share associated with a single job queue.
pub const FrontOfQuotaSharesDetail = struct {
    /// The Unix timestamp (in milliseconds) for when the first `RUNNABLE` job per
    /// quota share were all last updated.
    last_updated_at: ?i64 = null,

    /// Contains a list of the first `RUNNABLE` job in each named quota share.
    quota_shares: ?[]const aws.map.MapEntry([]const FrontOfQuotaShareJobSummary) = null,

    pub const json_field_names = .{
        .last_updated_at = "lastUpdatedAt",
        .quota_shares = "quotaShares",
    };
};
