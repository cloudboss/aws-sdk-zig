const LFTag = @import("lf_tag.zig").LFTag;
const ResourceType = @import("resource_type.zig").ResourceType;

/// A structure containing a list of LF-tag conditions or saved LF-Tag
/// expressions that apply to a resource's LF-tag policy.
pub const LFTagPolicyResource = struct {
    /// The identifier for the Data Catalog. By default, the account ID. The Data
    /// Catalog is the persistent metadata store. It contains database definitions,
    /// table definitions, and other control information to manage your Lake
    /// Formation environment.
    catalog_id: ?[]const u8 = null,

    /// A list of LF-tag conditions or a saved expression that apply to the
    /// resource's LF-tag policy.
    expression: []const LFTag = &.{},

    /// If provided, permissions are granted to the Data Catalog resources whose
    /// assigned LF-Tags
    /// match the expression body of the saved expression under the provided
    /// `ExpressionName`.
    expression_name: ?[]const u8 = null,

    /// The resource type for which the LF-tag policy applies.
    resource_type: ResourceType,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .expression = "Expression",
        .expression_name = "ExpressionName",
        .resource_type = "ResourceType",
    };
};
