const IssueLocation = @import("issue_location.zig").IssueLocation;
const Priority = @import("priority.zig").Priority;

/// Contains a recommendation for bot optimization identified by the Bot
/// Analyzer.
pub const BotAnalyzerRecommendation = struct {
    /// A detailed description of the identified configuration issue.
    issue_description: []const u8,

    /// The location information for the identified issue within the bot
    /// configuration.
    issue_location: IssueLocation,

    /// The priority level of the recommendation.
    ///
    /// Valid Values: `High | Medium | Low`
    priority: Priority,

    /// The recommended solution to address the identified issue.
    proposed_fix: []const u8,

    pub const json_field_names = .{
        .issue_description = "issueDescription",
        .issue_location = "issueLocation",
        .priority = "priority",
        .proposed_fix = "proposedFix",
    };
};
