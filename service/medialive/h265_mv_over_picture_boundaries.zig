/// H265 Mv Over Picture Boundaries
pub const H265MvOverPictureBoundaries = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
