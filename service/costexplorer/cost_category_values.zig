const MatchOption = @import("match_option.zig").MatchOption;

/// The Cost Categories values used for filtering the costs.
///
/// If `Values` and `Key` are not specified, the `ABSENT`
/// `MatchOption` is applied to all Cost Categories. That is, it filters on
/// resources that aren't mapped to any Cost Categories.
///
/// If `Values` is provided and `Key` isn't specified, the
/// `ABSENT`
/// `MatchOption` is applied to the Cost Categories `Key` only. That
/// is, it filters on resources without the given Cost Categories key.
pub const CostCategoryValues = struct {
    key: ?[]const u8,

    /// The match options that you can use to filter your results. MatchOptions is
    /// only
    /// applicable for actions related to cost category. The default values for
    /// `MatchOptions` is `EQUALS` and `CASE_SENSITIVE`.
    match_options: ?[]const MatchOption,

    /// The specific value of the cost category.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .match_options = "MatchOptions",
        .values = "Values",
    };
};
