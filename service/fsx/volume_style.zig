pub const VolumeStyle = enum {
    flexvol,
    flexgroup,

    pub const json_field_names = .{
        .flexvol = "FLEXVOL",
        .flexgroup = "FLEXGROUP",
    };
};
