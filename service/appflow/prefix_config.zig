const PathPrefix = @import("path_prefix.zig").PathPrefix;
const PrefixFormat = @import("prefix_format.zig").PrefixFormat;
const PrefixType = @import("prefix_type.zig").PrefixType;

/// Specifies elements that Amazon AppFlow includes in the file and folder names
/// in the flow
/// destination.
pub const PrefixConfig = struct {
    /// Specifies whether the destination file path includes either or both of the
    /// following
    /// elements:
    ///
    /// **EXECUTION_ID**
    ///
    /// The ID that Amazon AppFlow assigns to the flow run.
    ///
    /// **SCHEMA_VERSION**
    ///
    /// The version number of your data schema. Amazon AppFlow assigns this version
    /// number. The version number increases by one when you change any of the
    /// following
    /// settings in your flow configuration:
    ///
    /// * Source-to-destination field mappings
    ///
    /// * Field data types
    ///
    /// * Partition keys
    path_prefix_hierarchy: ?[]const PathPrefix,

    /// Determines the level of granularity for the date and time that's included in
    /// the prefix.
    prefix_format: ?PrefixFormat,

    /// Determines the format of the prefix, and whether it applies to the file
    /// name, file path,
    /// or both.
    prefix_type: ?PrefixType,

    pub const json_field_names = .{
        .path_prefix_hierarchy = "pathPrefixHierarchy",
        .prefix_format = "prefixFormat",
        .prefix_type = "prefixType",
    };
};
