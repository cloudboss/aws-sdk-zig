const DetailedGlossaryTerm = @import("detailed_glossary_term.zig").DetailedGlossaryTerm;
const TimeSeriesDataPointSummaryFormOutput = @import("time_series_data_point_summary_form_output.zig").TimeSeriesDataPointSummaryFormOutput;

/// An asset published in an Amazon DataZone catalog.
pub const AssetListing = struct {
    /// The identifier of an asset published in an Amazon DataZone catalog.
    asset_id: ?[]const u8,

    /// The revision of an asset published in an Amazon DataZone catalog.
    asset_revision: ?[]const u8,

    /// The type of an asset published in an Amazon DataZone catalog.
    asset_type: ?[]const u8,

    /// The timestamp of when an asset published in an Amazon DataZone catalog was
    /// created.
    created_at: ?i64,

    /// The metadata forms attached to an asset published in an Amazon DataZone
    /// catalog.
    forms: ?[]const u8,

    /// The glossary terms attached to an asset published in an Amazon DataZone
    /// catalog.
    glossary_terms: ?[]const DetailedGlossaryTerm,

    /// The restricted glossary terms associated with an asset.
    governed_glossary_terms: ?[]const DetailedGlossaryTerm,

    /// The latest time series data points forms included in the additional
    /// attributes of an asset.
    latest_time_series_data_point_forms: ?[]const TimeSeriesDataPointSummaryFormOutput,

    /// The identifier of the project where an asset published in an Amazon DataZone
    /// catalog exists.
    owning_project_id: ?[]const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .asset_revision = "assetRevision",
        .asset_type = "assetType",
        .created_at = "createdAt",
        .forms = "forms",
        .glossary_terms = "glossaryTerms",
        .governed_glossary_terms = "governedGlossaryTerms",
        .latest_time_series_data_point_forms = "latestTimeSeriesDataPointForms",
        .owning_project_id = "owningProjectId",
    };
};
