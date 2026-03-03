const RealTimeContactAnalysisPostContactSummaryFailureCode = @import("real_time_contact_analysis_post_contact_summary_failure_code.zig").RealTimeContactAnalysisPostContactSummaryFailureCode;
const RealTimeContactAnalysisPostContactSummaryStatus = @import("real_time_contact_analysis_post_contact_summary_status.zig").RealTimeContactAnalysisPostContactSummaryStatus;

/// Information about the post-contact summary for a real-time contact segment.
pub const RealTimeContactAnalysisSegmentPostContactSummary = struct {
    /// The content of the summary.
    content: ?[]const u8 = null,

    /// If the summary failed to be generated, one of the following failure codes
    /// occurs:
    ///
    /// * `QUOTA_EXCEEDED`: The number of concurrent analytics jobs reached your
    ///   service quota.
    ///
    /// * `INSUFFICIENT_CONVERSATION_CONTENT`: The conversation needs to have at
    ///   least one turn from both the
    /// participants in order to generate the summary.
    ///
    /// * `FAILED_SAFETY_GUIDELINES`: The generated summary cannot be provided
    ///   because it failed to meet
    /// system safety guidelines.
    ///
    /// * `INVALID_ANALYSIS_CONFIGURATION`: This code occurs when, for example,
    ///   you're using a
    ///   [language](https://docs.aws.amazon.com/connect/latest/adminguide/supported-languages.html#supported-languages-contact-lens) that isn't supported by generative AI-powered post-contact summaries.
    ///
    /// * `INTERNAL_ERROR`: Internal system error.
    failure_code: ?RealTimeContactAnalysisPostContactSummaryFailureCode = null,

    /// Whether the summary was successfully COMPLETED or FAILED to be generated.
    status: RealTimeContactAnalysisPostContactSummaryStatus,

    pub const json_field_names = .{
        .content = "Content",
        .failure_code = "FailureCode",
        .status = "Status",
    };
};
