pub const AssetExtensionType = enum {
    ico,
    jpeg,
    png,
    svg,
    webp,

    pub const json_field_names = .{
        .ico = "ICO",
        .jpeg = "JPEG",
        .png = "PNG",
        .svg = "SVG",
        .webp = "WEBP",
    };
};
