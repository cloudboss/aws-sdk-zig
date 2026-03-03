const AlternatePathHint = @import("alternate_path_hint.zig").AlternatePathHint;
const Explanation = @import("explanation.zig").Explanation;
const PathComponent = @import("path_component.zig").PathComponent;
const AnalysisStatus = @import("analysis_status.zig").AnalysisStatus;
const Tag = @import("tag.zig").Tag;

/// Describes a network insights analysis.
pub const NetworkInsightsAnalysis = struct {
    /// The member accounts that contain resources that the path can traverse.
    additional_accounts: ?[]const []const u8 = null,

    /// Potential intermediate components.
    alternate_path_hints: ?[]const AlternatePathHint = null,

    /// The explanations. For more information, see [Reachability Analyzer
    /// explanation
    /// codes](https://docs.aws.amazon.com/vpc/latest/reachability/explanation-codes.html).
    explanations: ?[]const Explanation = null,

    /// The Amazon Resource Names (ARN) of the resources that the path must
    /// traverse.
    filter_in_arns: ?[]const []const u8 = null,

    /// The Amazon Resource Names (ARN) of the resources that the path must ignore.
    filter_out_arns: ?[]const []const u8 = null,

    /// The components in the path from source to destination.
    forward_path_components: ?[]const PathComponent = null,

    /// The Amazon Resource Name (ARN) of the network insights analysis.
    network_insights_analysis_arn: ?[]const u8 = null,

    /// The ID of the network insights analysis.
    network_insights_analysis_id: ?[]const u8 = null,

    /// The ID of the path.
    network_insights_path_id: ?[]const u8 = null,

    /// Indicates whether the destination is reachable from the source.
    network_path_found: ?bool = null,

    /// The components in the path from destination to source.
    return_path_components: ?[]const PathComponent = null,

    /// The time the analysis started.
    start_date: ?i64 = null,

    /// The status of the network insights analysis.
    status: ?AnalysisStatus = null,

    /// The status message, if the status is `failed`.
    status_message: ?[]const u8 = null,

    /// Potential intermediate accounts.
    suggested_accounts: ?[]const []const u8 = null,

    /// The tags.
    tags: ?[]const Tag = null,

    /// The warning message.
    warning_message: ?[]const u8 = null,
};
