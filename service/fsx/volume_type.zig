pub const VolumeType = enum {
    ontap,
    openzfs,

    pub const json_field_names = .{
        .ontap = "ONTAP",
        .openzfs = "OPENZFS",
    };
};
