const ExpandConfiguration = @import("expand_configuration.zig").ExpandConfiguration;
const MissingAttributeKeyStrategy = @import("missing_attribute_key_strategy.zig").MissingAttributeKeyStrategy;
const SortingConfiguration = @import("sorting_configuration.zig").SortingConfiguration;

/// Specifies how to group results by document attribute value, and how to
/// display them
/// collapsed/expanded under a designated primary document for each group.
pub const CollapseConfiguration = struct {
    /// The document attribute used to group search results. You can use any
    /// attribute that
    /// has the `Sortable` flag set to true. You can also sort by any of the
    /// following built-in attributes:"_category","_created_at", "_last_updated_at",
    /// "_version",
    /// "_view_count".
    document_attribute_key: []const u8,

    /// Specifies whether to expand the collapsed results.
    expand: bool = false,

    /// Provides configuration information to customize expansion options for a
    /// collapsed
    /// group.
    expand_configuration: ?ExpandConfiguration = null,

    /// Specifies the behavior for documents without a value for the collapse
    /// attribute.
    ///
    /// Amazon Kendra offers three customization options:
    ///
    /// * Choose to `COLLAPSE` all documents with null or missing values in
    /// one group. This is the default configuration.
    ///
    /// * Choose to `IGNORE` documents with null or missing values. Ignored
    /// documents will not appear in query results.
    ///
    /// * Choose to `EXPAND` each document with a null or missing value into
    /// a group of its own.
    missing_attribute_key_strategy: ?MissingAttributeKeyStrategy = null,

    /// A prioritized list of document attributes/fields that determine the primary
    /// document
    /// among those in a collapsed group.
    sorting_configurations: ?[]const SortingConfiguration = null,

    pub const json_field_names = .{
        .document_attribute_key = "DocumentAttributeKey",
        .expand = "Expand",
        .expand_configuration = "ExpandConfiguration",
        .missing_attribute_key_strategy = "MissingAttributeKeyStrategy",
        .sorting_configurations = "SortingConfigurations",
    };
};
