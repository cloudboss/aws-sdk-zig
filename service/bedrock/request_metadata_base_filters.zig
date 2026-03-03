const aws = @import("aws");

/// A mapping of a metadata key to a value that it should or should not equal.
pub const RequestMetadataBaseFilters = struct {
    /// Include results where the key equals the value.
    equals: ?[]const aws.map.StringMapEntry = null,

    /// Include results where the key does not equal the value.
    not_equals: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .equals = "equals",
        .not_equals = "notEquals",
    };
};
