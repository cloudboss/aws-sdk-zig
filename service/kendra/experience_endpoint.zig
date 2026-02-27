const EndpointType = @import("endpoint_type.zig").EndpointType;

/// Provides the configuration information for the endpoint for your Amazon
/// Kendra
/// experience.
pub const ExperienceEndpoint = struct {
    /// The endpoint of your Amazon Kendra experience.
    endpoint: ?[]const u8,

    /// The type of endpoint for your Amazon Kendra experience. The type currently
    /// available
    /// is `HOME`, which is a unique and fully hosted URL to the home page
    /// of your Amazon Kendra experience.
    endpoint_type: ?EndpointType,

    pub const json_field_names = .{
        .endpoint = "Endpoint",
        .endpoint_type = "EndpointType",
    };
};
