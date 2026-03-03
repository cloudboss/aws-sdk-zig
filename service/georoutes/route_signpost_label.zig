const RouteNumber = @import("route_number.zig").RouteNumber;
const LocalizedString = @import("localized_string.zig").LocalizedString;

/// Labels presented on the sign post.
pub const RouteSignpostLabel = struct {
    /// Route number of the road.
    route_number: ?RouteNumber = null,

    /// The Signpost text.
    text: ?LocalizedString = null,

    pub const json_field_names = .{
        .route_number = "RouteNumber",
        .text = "Text",
    };
};
