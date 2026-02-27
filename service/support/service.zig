const Category = @import("category.zig").Category;

/// Information about an Amazon Web Services service returned by the
/// DescribeServices
/// operation.
pub const Service = struct {
    /// A list of categories that describe the type of support issue a case
    /// describes.
    /// Categories consist of a category name and a category code. Category names
    /// and codes are
    /// passed to Amazon Web Services Support when you call CreateCase.
    categories: ?[]const Category,

    /// The code for an Amazon Web Services service returned by the DescribeServices
    /// response. The `name` element contains the corresponding friendly name.
    code: ?[]const u8,

    /// The friendly name for an Amazon Web Services service. The `code` element
    /// contains the
    /// corresponding code.
    name: ?[]const u8,

    pub const json_field_names = .{
        .categories = "categories",
        .code = "code",
        .name = "name",
    };
};
