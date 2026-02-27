pub const ContributionAnalysisSortType = enum {
    absolute_difference,
    contribution_percentage,
    deviation_from_expected,
    percentage_difference,

    pub const json_field_names = .{
        .absolute_difference = "ABSOLUTE_DIFFERENCE",
        .contribution_percentage = "CONTRIBUTION_PERCENTAGE",
        .deviation_from_expected = "DEVIATION_FROM_EXPECTED",
        .percentage_difference = "PERCENTAGE_DIFFERENCE",
    };
};
