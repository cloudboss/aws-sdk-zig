/// Information that your application adds to authentication requests. Applies
/// an endpoint
/// ID to the analytics data that your user pool sends to Amazon Pinpoint.
///
/// An endpoint ID uniquely identifies a mobile device, email address or phone
/// number that
/// can receive messages from Amazon Pinpoint analytics. For more information
/// about Amazon Web Services Regions that
/// can contain Amazon Pinpoint resources for use with Amazon Cognito user
/// pools, see [Using Amazon Pinpoint analytics with Amazon Cognito user
/// pools](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-pinpoint-integration.html).
pub const AnalyticsMetadataType = struct {
    /// The endpoint ID. Information that you want to pass to Amazon Pinpoint about
    /// where to send
    /// notifications.
    analytics_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .analytics_endpoint_id = "AnalyticsEndpointId",
    };
};
