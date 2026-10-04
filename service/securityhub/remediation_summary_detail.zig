const KbArticle = @import("kb_article.zig").KbArticle;

/// A summary of the remediation target.
pub const RemediationSummaryDetail = struct {
    /// A summarized action to take for the remediation target.
    action: []const u8,

    /// A description of the remediation target.
    description: ?[]const u8 = null,

    /// Specifies whether the effect of this target is immediate.
    is_immediate: bool,

    /// An array of `KbArticle` objects.
    kb_articles: ?[]const KbArticle = null,

    /// An array of steps to be taken after remediation.
    post_remediation_steps: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .action = "Action",
        .description = "Description",
        .is_immediate = "IsImmediate",
        .kb_articles = "KbArticles",
        .post_remediation_steps = "PostRemediationSteps",
    };
};
