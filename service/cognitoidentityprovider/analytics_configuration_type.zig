/// The settings for Amazon Pinpoint analytics configuration. With an analytics
/// configuration,
/// your application can collect user-activity metrics for user notifications
/// with a Amazon Pinpoint
/// campaign.
///
/// Amazon Pinpoint isn't available in all Amazon Web Services Regions. For a
/// list of available Regions, see
/// [Amazon Cognito and Amazon Pinpoint Region
/// availability](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-pinpoint-integration.html#cognito-user-pools-find-region-mappings).
pub const AnalyticsConfigurationType = struct {
    /// The Amazon Resource Name (ARN) of an Amazon Pinpoint project that you want
    /// to connect to
    /// your user pool app client. Amazon Cognito publishes events to the Amazon
    /// Pinpoint project that
    /// `ApplicationArn` declares. You can also configure your application to
    /// pass an endpoint ID in the `AnalyticsMetadata` parameter of sign-in
    /// operations. The endpoint ID is information about the destination for push
    /// notifications
    application_arn: ?[]const u8 = null,

    /// Your Amazon Pinpoint project ID.
    application_id: ?[]const u8 = null,

    /// The [external
    /// ID](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html) of the role that Amazon Cognito assumes to send
    /// analytics data to Amazon Pinpoint.
    external_id: ?[]const u8 = null,

    /// The ARN of an Identity and Access Management role that has the permissions
    /// required for Amazon Cognito to publish
    /// events to Amazon Pinpoint analytics.
    role_arn: ?[]const u8 = null,

    /// If `UserDataShared` is `true`, Amazon Cognito includes user data in the
    /// events that it publishes to Amazon Pinpoint analytics.
    user_data_shared: bool = false,

    pub const json_field_names = .{
        .application_arn = "ApplicationArn",
        .application_id = "ApplicationId",
        .external_id = "ExternalId",
        .role_arn = "RoleArn",
        .user_data_shared = "UserDataShared",
    };
};
