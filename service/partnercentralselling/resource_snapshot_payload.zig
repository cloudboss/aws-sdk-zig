const AwsOpportunitySummaryFullView = @import("aws_opportunity_summary_full_view.zig").AwsOpportunitySummaryFullView;
const OpportunitySummaryView = @import("opportunity_summary_view.zig").OpportunitySummaryView;

/// Represents the payload of a resource snapshot. This structure is designed to
/// accommodate different types of resource snapshots, currently supporting
/// opportunity summaries.
pub const ResourceSnapshotPayload = union(enum) {
    /// Provides a comprehensive view of AwsOpportunitySummaryFullView template.
    aws_opportunity_summary_full_view: ?AwsOpportunitySummaryFullView,
    /// An object that contains an `opportunity`'s subset of fields.
    opportunity_summary: ?OpportunitySummaryView,

    pub const json_field_names = .{
        .aws_opportunity_summary_full_view = "AwsOpportunitySummaryFullView",
        .opportunity_summary = "OpportunitySummary",
    };
};
