/// Specifies demographic information about an endpoint, such as the applicable
/// time zone and platform.
pub const EndpointDemographic = struct {
    /// The version of the app that's associated with the endpoint.
    app_version: ?[]const u8,

    /// The locale of the endpoint, in the following format: the ISO 639-1 alpha-2
    /// code, followed by an underscore (_), followed by an ISO 3166-1 alpha-2
    /// value.
    locale: ?[]const u8,

    /// The manufacturer of the endpoint device, such as apple or samsung.
    make: ?[]const u8,

    /// The model name or number of the endpoint device, such as iPhone or SM-G900F.
    model: ?[]const u8,

    /// The model version of the endpoint device.
    model_version: ?[]const u8,

    /// The platform of the endpoint device, such as ios.
    platform: ?[]const u8,

    /// The platform version of the endpoint device.
    platform_version: ?[]const u8,

    /// The time zone of the endpoint, specified as a tz database name value, such
    /// as America/Los_Angeles.
    timezone: ?[]const u8,

    pub const json_field_names = .{
        .app_version = "AppVersion",
        .locale = "Locale",
        .make = "Make",
        .model = "Model",
        .model_version = "ModelVersion",
        .platform = "Platform",
        .platform_version = "PlatformVersion",
        .timezone = "Timezone",
    };
};
