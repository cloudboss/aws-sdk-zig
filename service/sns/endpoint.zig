const aws = @import("aws");

/// The endpoint for mobile app and device.
pub const Endpoint = struct {
    /// Attributes for endpoint.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The `EndpointArn` for mobile app and device.
    endpoint_arn: ?[]const u8 = null,
};
