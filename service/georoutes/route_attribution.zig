const RouteAttributionType = @import("route_attribution_type.zig").RouteAttributionType;
const RouteWebLink = @import("route_web_link.zig").RouteWebLink;

/// Required attribution to display.
pub const RouteAttribution = struct {
    /// The type of the attribution link.
    attribution_type: ?RouteAttributionType = null,

    /// The URL to an external resource.
    web_link: RouteWebLink,

    pub const json_field_names = .{
        .attribution_type = "AttributionType",
        .web_link = "WebLink",
    };
};
