pub const TaskFilterName = enum {
    location_id,
    creation_time,

    pub const json_field_names = .{
        .location_id = "LocationId",
        .creation_time = "CreationTime",
    };
};
