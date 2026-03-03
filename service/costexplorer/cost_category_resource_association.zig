/// A reference to a cost category association that contains information on an
/// associated resource.
pub const CostCategoryResourceAssociation = struct {
    /// The unique identifier for your cost category.
    cost_category_arn: ?[]const u8 = null,

    cost_category_name: ?[]const u8 = null,

    /// The unique identifier for an associated resource.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cost_category_arn = "CostCategoryArn",
        .cost_category_name = "CostCategoryName",
        .resource_arn = "ResourceArn",
    };
};
