/// Enable use of tiles, allowing horizontal as well as vertical subdivision of
/// the encoded pictures.
pub const H265Tiles = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
