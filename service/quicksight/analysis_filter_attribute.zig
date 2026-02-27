pub const AnalysisFilterAttribute = enum {
    quicksight_user,
    quicksight_viewer_or_owner,
    direct_quicksight_viewer_or_owner,
    quicksight_owner,
    direct_quicksight_owner,
    direct_quicksight_sole_owner,
    analysis_name,

    pub const json_field_names = .{
        .quicksight_user = "QUICKSIGHT_USER",
        .quicksight_viewer_or_owner = "QUICKSIGHT_VIEWER_OR_OWNER",
        .direct_quicksight_viewer_or_owner = "DIRECT_QUICKSIGHT_VIEWER_OR_OWNER",
        .quicksight_owner = "QUICKSIGHT_OWNER",
        .direct_quicksight_owner = "DIRECT_QUICKSIGHT_OWNER",
        .direct_quicksight_sole_owner = "DIRECT_QUICKSIGHT_SOLE_OWNER",
        .analysis_name = "ANALYSIS_NAME",
    };
};
