const EligibleDataSource = @import("eligible_data_source.zig").EligibleDataSource;

/// Rules for retrieving content from data sources connected to a Amazon Q
/// Business application for a specific topic control configuration.
pub const ContentRetrievalRule = struct {
    /// Specifies data sources in a Amazon Q Business application to use for content
    /// generation.
    eligible_data_sources: ?[]const EligibleDataSource = null,

    pub const json_field_names = .{
        .eligible_data_sources = "eligibleDataSources",
    };
};
