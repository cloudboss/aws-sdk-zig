/// The custom structure represents a complex or higher-order data structure.
pub const CustomStruct = struct {
    /// A comment in addition to the description.
    comment: ?[]const u8,

    /// The deprecation message for the node or the branch that was moved or
    /// deleted.
    deprecation_message: ?[]const u8,

    /// A brief description of the custom structure.
    description: ?[]const u8,

    /// The fully qualified name of the custom structure. For example, the fully
    /// qualified
    /// name of a custom structure might be
    /// `ComplexDataTypes.VehicleDataTypes.SVMCamera`.
    fully_qualified_name: []const u8,

    pub const json_field_names = .{
        .comment = "comment",
        .deprecation_message = "deprecationMessage",
        .description = "description",
        .fully_qualified_name = "fullyQualifiedName",
    };
};
