const Predicate = @import("predicate.zig").Predicate;
const SortProperty = @import("sort_property.zig").SortProperty;

/// Describes the configuration for binding a component's properties to data.
pub const ComponentDataConfiguration = struct {
    /// A list of IDs to use to bind data to a component. Use this property to bind
    /// specifically
    /// chosen data, rather than data retrieved from a query.
    identifiers: ?[]const []const u8 = null,

    /// The name of the data model to use to bind data to a component.
    model: []const u8,

    /// Represents the conditional logic to use when binding data to a component.
    /// Use this
    /// property to retrieve only a subset of the data in a collection.
    predicate: ?Predicate = null,

    /// Describes how to sort the component's properties.
    sort: ?[]const SortProperty = null,

    pub const json_field_names = .{
        .identifiers = "identifiers",
        .model = "model",
        .predicate = "predicate",
        .sort = "sort",
    };
};
