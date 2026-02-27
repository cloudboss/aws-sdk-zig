/// H264 Force Field Pictures
pub const H264ForceFieldPictures = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
