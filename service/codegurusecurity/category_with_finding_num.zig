/// Information about a finding category with open findings.
pub const CategoryWithFindingNum = struct {
    /// The name of the finding category. A finding category is determined by the
    /// detector that detected the finding.
    category_name: ?[]const u8,

    /// The number of open findings in the category.
    finding_number: ?i32,

    pub const json_field_names = .{
        .category_name = "categoryName",
        .finding_number = "findingNumber",
    };
};
