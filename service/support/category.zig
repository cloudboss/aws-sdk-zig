/// A JSON-formatted name/value pair that represents the category name and
/// category code
/// of the problem, selected from the DescribeServices response for each
/// Amazon Web Services service.
pub const Category = struct {
    /// The category code for the support case.
    code: ?[]const u8,

    /// The category name for the support case.
    name: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .name = "name",
    };
};
