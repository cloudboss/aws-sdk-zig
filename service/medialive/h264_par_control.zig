/// H264 Par Control
pub const H264ParControl = enum {
    initialize_from_source,
    specified,

    pub const json_field_names = .{
        .initialize_from_source = "INITIALIZE_FROM_SOURCE",
        .specified = "SPECIFIED",
    };
};
