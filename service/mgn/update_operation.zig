const aws = @import("aws");

/// An operation that updates the properties of a construct.
pub const UpdateOperation = struct {
    /// The properties to update on the construct.
    properties: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .properties = "properties",
    };
};
