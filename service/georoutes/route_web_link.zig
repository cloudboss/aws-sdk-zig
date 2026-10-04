const RouteWebLinkDeviceType = @import("route_web_link_device_type.zig").RouteWebLinkDeviceType;

/// The URL to an external resource.
pub const RouteWebLink = struct {
    /// The interactive or clickable portion of the text.
    anchor_text: ?[]const u8 = null,

    /// Text describing the URL.
    description: []const u8,

    /// Device type for which the link is intended.
    device_type: ?RouteWebLinkDeviceType = null,

    /// The URL of the link.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .anchor_text = "AnchorText",
        .description = "Description",
        .device_type = "DeviceType",
        .url = "Url",
    };
};
