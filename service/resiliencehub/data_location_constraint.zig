pub const DataLocationConstraint = enum {
    any_location,
    same_continent,
    same_country,

    pub const json_field_names = .{
        .any_location = "ANY_LOCATION",
        .same_continent = "SAME_CONTINENT",
        .same_country = "SAME_COUNTRY",
    };
};
