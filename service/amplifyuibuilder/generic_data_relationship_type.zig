pub const GenericDataRelationshipType = enum {
    has_many,
    has_one,
    belongs_to,

    pub const json_field_names = .{
        .has_many = "HAS_MANY",
        .has_one = "HAS_ONE",
        .belongs_to = "BELONGS_TO",
    };
};
