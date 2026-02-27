const ImplementationFilter = @import("implementation_filter.zig").ImplementationFilter;

/// A structure that defines filtering criteria for the ListControls operation.
/// You can use this filter to narrow down the list of controls based on their
/// implementation details.
pub const ControlFilter = struct {
    /// A filter that narrows the results to controls with specific implementation
    /// types or identifiers. This field allows you to find controls that are
    /// implemented by specific Amazon Web Services services or with specific
    /// service identifiers.
    implementations: ?ImplementationFilter,

    pub const json_field_names = .{
        .implementations = "Implementations",
    };
};
