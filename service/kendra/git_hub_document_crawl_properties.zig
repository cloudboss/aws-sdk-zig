/// Provides the configuration information to include certain types of GitHub
/// content. You
/// can configure to index repository files only, or also include issues and
/// pull requests,
/// comments, and comment attachments.
pub const GitHubDocumentCrawlProperties = struct {
    /// `TRUE` to index all issues within a repository.
    crawl_issue: bool = false,

    /// `TRUE` to index all comments on issues.
    crawl_issue_comment: bool = false,

    /// `TRUE` to include all comment attachments for issues.
    crawl_issue_comment_attachment: bool = false,

    /// `TRUE` to index all pull requests within a repository.
    crawl_pull_request: bool = false,

    /// `TRUE` to index all comments on pull requests.
    crawl_pull_request_comment: bool = false,

    /// `TRUE` to include all comment attachments for pull requests.
    crawl_pull_request_comment_attachment: bool = false,

    /// `TRUE` to index all files with a repository.
    crawl_repository_documents: bool = false,

    pub const json_field_names = .{
        .crawl_issue = "CrawlIssue",
        .crawl_issue_comment = "CrawlIssueComment",
        .crawl_issue_comment_attachment = "CrawlIssueCommentAttachment",
        .crawl_pull_request = "CrawlPullRequest",
        .crawl_pull_request_comment = "CrawlPullRequestComment",
        .crawl_pull_request_comment_attachment = "CrawlPullRequestCommentAttachment",
        .crawl_repository_documents = "CrawlRepositoryDocuments",
    };
};
