const SetDimension = @import("set_dimension.zig").SetDimension;

/// Specifies demographic-based dimension settings for including or excluding
/// endpoints from a segment. These settings derive from characteristics of
/// endpoint devices, such as platform, make, and model.
pub const SegmentDemographics = struct {
    /// The app version criteria for the segment.
    app_version: ?SetDimension,

    /// The channel criteria for the segment.
    channel: ?SetDimension,

    /// The device type criteria for the segment.
    device_type: ?SetDimension,

    /// The device make criteria for the segment.
    make: ?SetDimension,

    /// The device model criteria for the segment.
    model: ?SetDimension,

    /// The device platform criteria for the segment.
    platform: ?SetDimension,

    pub const json_field_names = .{
        .app_version = "AppVersion",
        .channel = "Channel",
        .device_type = "DeviceType",
        .make = "Make",
        .model = "Model",
        .platform = "Platform",
    };
};
