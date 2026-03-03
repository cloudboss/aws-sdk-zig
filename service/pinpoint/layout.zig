const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bottom_banner => "BOTTOM_BANNER",
            .top_banner => "TOP_BANNER",
            .overlays => "OVERLAYS",
            .mobile_feed => "MOBILE_FEED",
            .middle_banner => "MIDDLE_BANNER",
            .carousel => "CAROUSEL",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
