const DateTimeHierarchy = @import("date_time_hierarchy.zig").DateTimeHierarchy;
const ExplicitHierarchy = @import("explicit_hierarchy.zig").ExplicitHierarchy;
const PredefinedHierarchy = @import("predefined_hierarchy.zig").PredefinedHierarchy;

/// The option that determines the hierarchy of the fields for a visual element.
pub const ColumnHierarchy = struct {
    /// The option that determines the hierarchy of any `DateTime` fields.
    date_time_hierarchy: ?DateTimeHierarchy = null,

    /// The option that determines the hierarchy of the fields that are built within
    /// a visual's field wells. These fields can't be duplicated to other visuals.
    explicit_hierarchy: ?ExplicitHierarchy = null,

    /// The option that determines the hierarchy of the fields that are defined
    /// during data preparation. These fields are available to use in any analysis
    /// that uses the data source.
    predefined_hierarchy: ?PredefinedHierarchy = null,

    pub const json_field_names = .{
        .date_time_hierarchy = "DateTimeHierarchy",
        .explicit_hierarchy = "ExplicitHierarchy",
        .predefined_hierarchy = "PredefinedHierarchy",
    };
};
