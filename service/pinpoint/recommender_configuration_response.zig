const aws = @import("aws");

/// Provides information about Amazon Pinpoint configuration settings for
/// retrieving and processing data from a recommender model.
pub const RecommenderConfigurationResponse = struct {
    /// A map that defines 1-10 custom endpoint or user attributes, depending on the
    /// value for the RecommendationProviderIdType property. Each of these
    /// attributes temporarily stores a recommended item that's retrieved from the
    /// recommender model and sent to an AWS Lambda function for additional
    /// processing. Each attribute can be used as a message variable in a message
    /// template.
    ///
    /// This value is null if the configuration doesn't invoke an AWS Lambda
    /// function (RecommendationTransformerUri) to perform additional processing of
    /// recommendation data.
    attributes: ?[]const aws.map.StringMapEntry,

    /// The date, in extended ISO 8601 format, when the configuration was created
    /// for the recommender model.
    creation_date: []const u8,

    /// The custom description of the configuration for the recommender model.
    description: ?[]const u8,

    /// The unique identifier for the recommender model configuration.
    id: []const u8,

    /// The date, in extended ISO 8601 format, when the configuration for the
    /// recommender model was last modified.
    last_modified_date: []const u8,

    /// The custom name of the configuration for the recommender model.
    name: ?[]const u8,

    /// The type of Amazon Pinpoint ID that's associated with unique user IDs in the
    /// recommender model. This value enables the model to use attribute and event
    /// data that’s specific to a particular endpoint or user in an Amazon Pinpoint
    /// application. Possible values are:
    ///
    /// * PINPOINT_ENDPOINT_ID - Each user in the model is associated with a
    ///   particular endpoint in Amazon Pinpoint. The data is correlated based on
    ///   endpoint IDs in Amazon Pinpoint. This is the default value.
    /// * PINPOINT_USER_ID - Each user in the model is associated with a particular
    ///   user and endpoint in Amazon Pinpoint. The data is correlated based on user
    ///   IDs in Amazon Pinpoint. If this value is specified, an endpoint definition
    ///   in Amazon Pinpoint has to specify both a user ID (UserId) and an endpoint
    ///   ID. Otherwise, messages won’t be sent to the user's endpoint.
    recommendation_provider_id_type: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the AWS Identity and Access Management
    /// (IAM) role that authorizes Amazon Pinpoint to retrieve recommendation data
    /// from the recommender model.
    recommendation_provider_role_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the recommender model that Amazon Pinpoint
    /// retrieves the recommendation data from. This value is the ARN of an Amazon
    /// Personalize campaign.
    recommendation_provider_uri: []const u8,

    /// The custom display name for the standard endpoint or user attribute
    /// (RecommendationItems) that temporarily stores recommended items for each
    /// endpoint or user, depending on the value for the
    /// RecommendationProviderIdType property. This name appears in the **Attribute
    /// finder** of the template editor on the Amazon Pinpoint console.
    ///
    /// This value is null if the configuration doesn't invoke an AWS Lambda
    /// function (RecommendationTransformerUri) to perform additional processing of
    /// recommendation data.
    recommendations_display_name: ?[]const u8,

    /// The number of recommended items that are retrieved from the model for each
    /// endpoint or user, depending on the value for the
    /// RecommendationProviderIdType property. This number determines how many
    /// recommended items are available for use in message variables.
    recommendations_per_message: ?i32,

    /// The name or Amazon Resource Name (ARN) of the AWS Lambda function that
    /// Amazon Pinpoint invokes to perform additional processing of recommendation
    /// data that it retrieves from the recommender model.
    recommendation_transformer_uri: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .creation_date = "CreationDate",
        .description = "Description",
        .id = "Id",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .recommendation_provider_id_type = "RecommendationProviderIdType",
        .recommendation_provider_role_arn = "RecommendationProviderRoleArn",
        .recommendation_provider_uri = "RecommendationProviderUri",
        .recommendations_display_name = "RecommendationsDisplayName",
        .recommendations_per_message = "RecommendationsPerMessage",
        .recommendation_transformer_uri = "RecommendationTransformerUri",
    };
};
