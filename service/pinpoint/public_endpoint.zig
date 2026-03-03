const aws = @import("aws");

const ChannelType = @import("channel_type.zig").ChannelType;
const EndpointDemographic = @import("endpoint_demographic.zig").EndpointDemographic;
const EndpointLocation = @import("endpoint_location.zig").EndpointLocation;
const EndpointUser = @import("endpoint_user.zig").EndpointUser;

/// Specifies the properties and attributes of an endpoint that's associated
/// with an event.
pub const PublicEndpoint = struct {
    /// The unique identifier for the recipient, such as a device token, email
    /// address, or mobile phone number.
    address: ?[]const u8 = null,

    /// One or more custom attributes that describe the endpoint by associating a
    /// name with an array of values. You can use these attributes as filter
    /// criteria when you create segments.
    attributes: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The channel that's used when sending messages or push notifications to the
    /// endpoint.
    channel_type: ?ChannelType = null,

    /// The demographic information for the endpoint, such as the time zone and
    /// platform.
    demographic: ?EndpointDemographic = null,

    /// The date and time, in ISO 8601 format, when the endpoint was last updated.
    effective_date: ?[]const u8 = null,

    /// Specifies whether to send messages or push notifications to the endpoint.
    /// Valid values are: ACTIVE, messages are sent to the endpoint; and, INACTIVE,
    /// messages aren’t sent to the endpoint.
    ///
    /// Amazon Pinpoint automatically sets this value to ACTIVE when you create an
    /// endpoint or update an existing endpoint. Amazon Pinpoint automatically sets
    /// this value to INACTIVE if you update another endpoint that has the same
    /// address specified by the Address property.
    endpoint_status: ?[]const u8 = null,

    /// The geographic information for the endpoint.
    location: ?EndpointLocation = null,

    /// One or more custom metrics that your app reports to Amazon Pinpoint for the
    /// endpoint.
    metrics: ?[]const aws.map.MapEntry(f64) = null,

    /// Specifies whether the user who's associated with the endpoint has opted out
    /// of receiving messages and push notifications from you. Possible values are:
    /// ALL, the user has opted out and doesn't want to receive any messages or push
    /// notifications; and, NONE, the user hasn't opted out and wants to receive all
    /// messages and push notifications.
    opt_out: ?[]const u8 = null,

    /// A unique identifier that's generated each time the endpoint is updated.
    request_id: ?[]const u8 = null,

    /// One or more custom user attributes that your app reports to Amazon Pinpoint
    /// for the user who's associated with the endpoint.
    user: ?EndpointUser = null,

    pub const json_field_names = .{
        .address = "Address",
        .attributes = "Attributes",
        .channel_type = "ChannelType",
        .demographic = "Demographic",
        .effective_date = "EffectiveDate",
        .endpoint_status = "EndpointStatus",
        .location = "Location",
        .metrics = "Metrics",
        .opt_out = "OptOut",
        .request_id = "RequestId",
        .user = "User",
    };
};
