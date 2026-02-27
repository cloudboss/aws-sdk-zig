/// Burn In Teletext Grid Control
pub const BurnInTeletextGridControl = enum {
    fixed,
    scaled,

    pub const json_field_names = .{
        .fixed = "FIXED",
        .scaled = "SCALED",
    };
};
