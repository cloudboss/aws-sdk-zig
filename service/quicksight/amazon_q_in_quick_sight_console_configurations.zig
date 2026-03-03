const DataQnAConfigurations = @import("data_qn_a_configurations.zig").DataQnAConfigurations;
const DataStoriesConfigurations = @import("data_stories_configurations.zig").DataStoriesConfigurations;
const ExecutiveSummaryConfigurations = @import("executive_summary_configurations.zig").ExecutiveSummaryConfigurations;
const GenerativeAuthoringConfigurations = @import("generative_authoring_configurations.zig").GenerativeAuthoringConfigurations;

/// A collection of Amazon Q feature configurations in an embedded Quick Sight
/// console.
pub const AmazonQInQuickSightConsoleConfigurations = struct {
    /// Adds generative Q&A capabilitiees to an embedded Quick Sight console.
    data_qn_a: ?DataQnAConfigurations = null,

    /// Adds the data stories feature to an embedded Quick Sight console.
    data_stories: ?DataStoriesConfigurations = null,

    /// Adds the executive summaries feature to an embedded Quick Sight console.
    executive_summary: ?ExecutiveSummaryConfigurations = null,

    /// Adds the generative BI authoring experience to an embedded Quick Sight
    /// console.
    generative_authoring: ?GenerativeAuthoringConfigurations = null,

    pub const json_field_names = .{
        .data_qn_a = "DataQnA",
        .data_stories = "DataStories",
        .executive_summary = "ExecutiveSummary",
        .generative_authoring = "GenerativeAuthoring",
    };
};
