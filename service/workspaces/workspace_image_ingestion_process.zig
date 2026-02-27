pub const WorkspaceImageIngestionProcess = enum {
    byol_regular,
    byol_graphics,
    byol_graphicspro,
    byol_graphics_g4_dn,
    byol_regular_wsp,
    byol_graphics_g4_dn_wsp,
    byol_regular_byop,
    byol_graphics_g4_dn_byop,

    pub const json_field_names = .{
        .byol_regular = "BYOL_REGULAR",
        .byol_graphics = "BYOL_GRAPHICS",
        .byol_graphicspro = "BYOL_GRAPHICSPRO",
        .byol_graphics_g4_dn = "BYOL_GRAPHICS_G4DN",
        .byol_regular_wsp = "BYOL_REGULAR_WSP",
        .byol_graphics_g4_dn_wsp = "BYOL_GRAPHICS_G4DN_WSP",
        .byol_regular_byop = "BYOL_REGULAR_BYOP",
        .byol_graphics_g4_dn_byop = "BYOL_GRAPHICS_G4DN_BYOP",
    };
};
