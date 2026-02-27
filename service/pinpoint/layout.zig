pub const Layout = enum {
    bottom_banner,
    top_banner,
    overlays,
    mobile_feed,
    middle_banner,
    carousel,

    pub const json_field_names = .{
        .bottom_banner = "BOTTOM_BANNER",
        .top_banner = "TOP_BANNER",
        .overlays = "OVERLAYS",
        .mobile_feed = "MOBILE_FEED",
        .middle_banner = "MIDDLE_BANNER",
        .carousel = "CAROUSEL",
    };
};
