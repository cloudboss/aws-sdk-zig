pub const LocationFilterName = enum {
    location_uri,
    location_type,
    creation_time,

    pub const json_field_names = .{
        .location_uri = "LocationUri",
        .location_type = "LocationType",
        .creation_time = "CreationTime",
    };
};
