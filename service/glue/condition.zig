const CrawlState = @import("crawl_state.zig").CrawlState;
const LogicalOperator = @import("logical_operator.zig").LogicalOperator;
const JobRunState = @import("job_run_state.zig").JobRunState;

/// Defines a condition under which a trigger fires.
pub const Condition = struct {
    /// The name of the crawler to which this condition applies.
    crawler_name: ?[]const u8,

    /// The state of the crawler to which this condition applies.
    crawl_state: ?CrawlState,

    /// The name of the job whose `JobRuns` this condition applies to, and on which
    /// this trigger waits.
    job_name: ?[]const u8,

    /// A logical operator.
    logical_operator: ?LogicalOperator,

    /// The condition state. Currently, the only job states that a trigger can
    /// listen for are `SUCCEEDED`, `STOPPED`, `FAILED`, and `TIMEOUT`. The only
    /// crawler states that a trigger can listen for are `SUCCEEDED`, `FAILED`, and
    /// `CANCELLED`.
    state: ?JobRunState,

    pub const json_field_names = .{
        .crawler_name = "CrawlerName",
        .crawl_state = "CrawlState",
        .job_name = "JobName",
        .logical_operator = "LogicalOperator",
        .state = "State",
    };
};
