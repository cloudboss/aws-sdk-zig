const aws = @import("aws");

const ChannelType = @import("channel_type.zig").ChannelType;
const EndpointDemographic = @import("endpoint_demographic.zig").EndpointDemographic;
const EndpointLocation = @import("endpoint_location.zig").EndpointLocation;
const EndpointUser = @import("endpoint_user.zig").EndpointUser;

/// Specifies an endpoint to create or update and the settings and attributes to
/// set or change for the endpoint.
pub const EndpointBatchItem = struct {
    /// The destination address for messages or push notifications that you send to
    /// the endpoint. The address varies by channel. For a push-notification
    /// channel, use the token provided by the push notification service, such as an
    /// Apple Push Notification service (APNs) device token or a Firebase Cloud
    /// Messaging (FCM) registration token. For the SMS channel, use a phone number
    /// in E.164 format, such as +12065550100. For the email channel, use an email
    /// address.
    address: ?[]const u8,

    /// One or more custom attributes that describe the endpoint by associating a
    /// name with an array of values. For example, the value of a custom attribute
    /// named Interests might be: ["Science", "Music", "Travel"]. You can use these
    /// attributes as filter criteria when you create segments. Attribute names are
    /// case sensitive.
    ///
    /// An attribute name can contain up to 50 characters. An attribute value can
    /// contain up to 100 characters. When you define the name of a custom
    /// attribute, avoid using the following characters: number sign (#), colon (:),
    /// question mark (?), backslash (\), and slash (/). The Amazon Pinpoint console
    /// can't display attribute names that contain these characters. This
    /// restriction doesn't apply to attribute values.
    attributes: ?[]const aws.map.MapEntry([]const []const u8),

    /// The channel to use when sending messages or push notifications to the
    /// endpoint.
    channel_type: ?ChannelType,

    /// The demographic information for the endpoint, such as the time zone and
    /// platform.
    demographic: ?EndpointDemographic,

    /// The date and time, in ISO 8601 format, when the endpoint was created or
    /// updated.
    effective_date: ?[]const u8,

    /// Specifies whether to send messages or push notifications to the endpoint.
    /// Valid values are: ACTIVE, messages are sent to the endpoint; and, INACTIVE,
    /// messages aren’t sent to the endpoint.
    ///
    /// Amazon Pinpoint automatically sets this value to ACTIVE when you create an
    /// endpoint or update an existing endpoint. Amazon Pinpoint automatically sets
    /// this value to INACTIVE if you update another endpoint that has the same
    /// address specified by the Address property.
    endpoint_status: ?[]const u8,

    /// The unique identifier for the endpoint in the context of the batch.
    id: ?[]const u8,

    /// The geographic information for the endpoint.
    location: ?EndpointLocation,

    /// One or more custom metrics that your app reports to Amazon Pinpoint for the
    /// endpoint.
    metrics: ?[]const aws.map.MapEntry(f64),

    /// Specifies whether the user who's associated with the endpoint has opted out
    /// of receiving messages and push notifications from you. Possible values are:
    /// ALL, the user has opted out and doesn't want to receive any messages or push
    /// notifications; and, NONE, the user hasn't opted out and wants to receive all
    /// messages and push notifications.
    opt_out: ?[]const u8,

    /// The unique identifier for the request to create or update the endpoint.
    request_id: ?[]const u8,

    /// One or more custom attributes that describe the user who's associated with
    /// the endpoint.
    user: ?EndpointUser,

    pub const json_field_names = .{
        .address = "Address",
        .attributes = "Attributes",
        .channel_type = "ChannelType",
        .demographic = "Demographic",
        .effective_date = "EffectiveDate",
        .endpoint_status = "EndpointStatus",
        .id = "Id",
        .location = "Location",
        .metrics = "Metrics",
        .opt_out = "OptOut",
        .request_id = "RequestId",
        .user = "User",
    };
};
