pub const HasLogicalRedundancy = enum {
    unknown,
    yes,
    no,

    pub const json_field_names = .{
        .unknown = "Unknown",
        .yes = "Yes",
        .no = "No",
    };
};
