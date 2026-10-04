const ProspectingResultAws = @import("prospecting_result_aws.zig").ProspectingResultAws;

/// Contains the results of an autonomous prospecting job. This includes data
/// and insights that AWS provides about a prospected customer account.
pub const ProspectingResult = struct {
    /// Prospecting data and insights that AWS provides during the prospecting job.
    /// This includes customer details, task information, and scoring that AI
    /// generates.
    aws: ?ProspectingResultAws = null,

    pub const json_field_names = .{
        .aws = "Aws",
    };
};
