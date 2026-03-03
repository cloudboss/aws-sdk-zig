const NodeDataEncoding = @import("node_data_encoding.zig").NodeDataEncoding;
const NodeDataType = @import("node_data_type.zig").NodeDataType;

/// Represents a member of the complex data structure. The data type of the
/// property can
/// be either primitive or another `struct`.
pub const CustomProperty = struct {
    /// A comment in addition to the description.
    comment: ?[]const u8 = null,

    /// Indicates whether the property is binary data.
    data_encoding: ?NodeDataEncoding = null,

    /// The data type for the custom property.
    data_type: NodeDataType,

    /// The deprecation message for the node or the branch that was moved or
    /// deleted.
    deprecation_message: ?[]const u8 = null,

    /// A brief description of the custom property.
    description: ?[]const u8 = null,

    /// The fully qualified name of the custom property. For example, the fully
    /// qualified name
    /// of a custom property might be
    /// `ComplexDataTypes.VehicleDataTypes.SVMCamera.FPS`.
    fully_qualified_name: []const u8,

    /// The fully qualified name of the struct node for the custom property if the
    /// data type
    /// of the custom property is `Struct` or `StructArray`.
    struct_fully_qualified_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .comment = "comment",
        .data_encoding = "dataEncoding",
        .data_type = "dataType",
        .deprecation_message = "deprecationMessage",
        .description = "description",
        .fully_qualified_name = "fullyQualifiedName",
        .struct_fully_qualified_name = "structFullyQualifiedName",
    };
};
