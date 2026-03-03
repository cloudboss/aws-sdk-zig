const SetDimension = @import("set_dimension.zig").SetDimension;

/// Specifies demographic-based dimension settings for including or excluding
/// endpoints from a segment. These settings derive from characteristics of
/// endpoint devices, such as platform, make, and model.
pub const SegmentDemographics = struct {
    /// The app version criteria for the segment.
    app_version: ?SetDimension = null,

    /// The channel criteria for the segment.
    channel: ?SetDimension = null,

    /// The device type criteria for the segment.
    device_type: ?SetDimension = null,

    /// The device make criteria for the segment.
    make: ?SetDimension = null,

    /// The device model criteria for the segment.
    model: ?SetDimension = null,

    /// The device platform criteria for the segment.
    platform: ?SetDimension = null,

    pub const json_field_names = .{
        .app_version = "AppVersion",
        .channel = "Channel",
        .device_type = "DeviceType",
        .make = "Make",
        .model = "Model",
        .platform = "Platform",
    };
};
