const aws = @import("aws");

const RequestMetadataBaseFilters = @import("request_metadata_base_filters.zig").RequestMetadataBaseFilters;

/// Rules for filtering invocation logs. A filter can be a mapping of a metadata
/// key to a value that it should or should not equal (a base filter), or a list
/// of base filters that are all applied with `AND` or `OR` logical operators
pub const RequestMetadataFilters = union(enum) {
    /// Include results where all of the based filters match.
    and_all: ?[]const RequestMetadataBaseFilters,
    /// Include results where the key equals the value.
    equals: ?[]const aws.map.StringMapEntry,
    /// Include results where the key does not equal the value.
    not_equals: ?[]const aws.map.StringMapEntry,
    /// Include results where any of the base filters match.
    or_all: ?[]const RequestMetadataBaseFilters,

    pub const json_field_names = .{
        .and_all = "andAll",
        .equals = "equals",
        .not_equals = "notEquals",
        .or_all = "orAll",
    };
};
