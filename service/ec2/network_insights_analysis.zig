const AlternatePathHint = @import("alternate_path_hint.zig").AlternatePathHint;
const Explanation = @import("explanation.zig").Explanation;
const PathComponent = @import("path_component.zig").PathComponent;
const AnalysisStatus = @import("analysis_status.zig").AnalysisStatus;
const Tag = @import("tag.zig").Tag;

/// Describes a network insights analysis.
pub const NetworkInsightsAnalysis = struct {
    /// The member accounts that contain resources that the path can traverse.
    additional_accounts: ?[]const []const u8,

    /// Potential intermediate components.
    alternate_path_hints: ?[]const AlternatePathHint,

    /// The explanations. For more information, see [Reachability Analyzer
    /// explanation
    /// codes](https://docs.aws.amazon.com/vpc/latest/reachability/explanation-codes.html).
    explanations: ?[]const Explanation,

    /// The Amazon Resource Names (ARN) of the resources that the path must
    /// traverse.
    filter_in_arns: ?[]const []const u8,

    /// The Amazon Resource Names (ARN) of the resources that the path must ignore.
    filter_out_arns: ?[]const []const u8,

    /// The components in the path from source to destination.
    forward_path_components: ?[]const PathComponent,

    /// The Amazon Resource Name (ARN) of the network insights analysis.
    network_insights_analysis_arn: ?[]const u8,

    /// The ID of the network insights analysis.
    network_insights_analysis_id: ?[]const u8,

    /// The ID of the path.
    network_insights_path_id: ?[]const u8,

    /// Indicates whether the destination is reachable from the source.
    network_path_found: ?bool,

    /// The components in the path from destination to source.
    return_path_components: ?[]const PathComponent,

    /// The time the analysis started.
    start_date: ?i64,

    /// The status of the network insights analysis.
    status: ?AnalysisStatus,

    /// The status message, if the status is `failed`.
    status_message: ?[]const u8,

    /// Potential intermediate accounts.
    suggested_accounts: ?[]const []const u8,

    /// The tags.
    tags: ?[]const Tag,

    /// The warning message.
    warning_message: ?[]const u8,
};
