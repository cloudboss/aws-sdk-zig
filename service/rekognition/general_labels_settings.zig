/// Contains filters for the object labels returned by DetectLabels. Filters can
/// be inclusive,
/// exclusive, or a combination of both and can be applied to individual labels
/// or entire label
/// categories. To see a list of label categories, see [Detecting
/// Labels](https://docs.aws.amazon.com/rekognition/latest/dg/labels.html).
pub const GeneralLabelsSettings = struct {
    /// The label categories that should be excluded from the return from
    /// DetectLabels.
    label_category_exclusion_filters: ?[]const []const u8,

    /// The label categories that should be included in the return from
    /// DetectLabels.
    label_category_inclusion_filters: ?[]const []const u8,

    /// The labels that should be excluded from the return from DetectLabels.
    label_exclusion_filters: ?[]const []const u8,

    /// The labels that should be included in the return from DetectLabels.
    label_inclusion_filters: ?[]const []const u8,

    pub const json_field_names = .{
        .label_category_exclusion_filters = "LabelCategoryExclusionFilters",
        .label_category_inclusion_filters = "LabelCategoryInclusionFilters",
        .label_exclusion_filters = "LabelExclusionFilters",
        .label_inclusion_filters = "LabelInclusionFilters",
    };
};
