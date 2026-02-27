pub const ServiceType = enum {
    assignment,
    id_mapping,

    pub const json_field_names = .{
        .assignment = "ASSIGNMENT",
        .id_mapping = "ID_MAPPING",
    };
};
