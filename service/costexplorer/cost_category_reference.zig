const CostCategoryProcessingStatus = @import("cost_category_processing_status.zig").CostCategoryProcessingStatus;

/// A reference to a cost category containing only enough information to
/// identify the Cost
/// Category.
///
/// You can use this information to retrieve the full cost category information
/// using
/// `DescribeCostCategory`.
pub const CostCategoryReference = struct {
    /// The unique identifier for your cost category.
    cost_category_arn: ?[]const u8,

    default_value: ?[]const u8,

    /// The cost category's effective end date.
    effective_end: ?[]const u8,

    /// The cost category's effective start date.
    effective_start: ?[]const u8,

    name: ?[]const u8,

    /// The number of rules that are associated with a specific cost category.
    number_of_rules: i32 = 0,

    /// The list of processing statuses for Cost Management products for a specific
    /// cost
    /// category.
    processing_status: ?[]const CostCategoryProcessingStatus,

    /// The resource types supported by a specific cost category.
    supported_resource_types: ?[]const []const u8,

    /// A list of unique cost category values in a specific cost category.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .cost_category_arn = "CostCategoryArn",
        .default_value = "DefaultValue",
        .effective_end = "EffectiveEnd",
        .effective_start = "EffectiveStart",
        .name = "Name",
        .number_of_rules = "NumberOfRules",
        .processing_status = "ProcessingStatus",
        .supported_resource_types = "SupportedResourceTypes",
        .values = "Values",
    };
};
