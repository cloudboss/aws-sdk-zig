const aws = @import("aws");

/// Specifies Amazon Pinpoint configuration settings for retrieving and
/// processing recommendation data from a recommender model.
pub const UpdateRecommenderConfigurationShape = struct {
    /// A map of key-value pairs that defines 1-10 custom endpoint or user
    /// attributes, depending on the value for the RecommendationProviderIdType
    /// property. Each of these attributes temporarily stores a recommended item
    /// that's retrieved from the recommender model and sent to an AWS Lambda
    /// function for additional processing. Each attribute can be used as a message
    /// variable in a message template.
    ///
    /// In the map, the key is the name of a custom attribute and the value is a
    /// custom display name for that attribute. The display name appears in the
    /// **Attribute finder** of the template editor on the Amazon Pinpoint console.
    /// The following restrictions apply to these names:
    ///
    /// * An attribute name must start with a letter or number and it can contain up
    ///   to 50 characters. The characters can be letters, numbers, underscores (_),
    ///   or hyphens (-). Attribute names are case sensitive and must be unique.
    /// * An attribute display name must start with a letter or number and it can
    ///   contain up to 25 characters. The characters can be letters, numbers,
    ///   spaces, underscores (_), or hyphens (-).
    ///
    /// This object is required if the configuration invokes an AWS Lambda function
    /// (RecommendationTransformerUri) to process recommendation data. Otherwise,
    /// don't include this object in your request.
    attributes: ?[]const aws.map.StringMapEntry,

    /// A custom description of the configuration for the recommender model. The
    /// description can contain up to 128 characters. The characters can be letters,
    /// numbers, spaces, or the following symbols: _ ; () , ‐.
    description: ?[]const u8,

    /// A custom name of the configuration for the recommender model. The name must
    /// start with a letter or number and it can contain up to 128 characters. The
    /// characters can be letters, numbers, spaces, underscores (_), or hyphens (-).
    name: ?[]const u8,

    /// The type of Amazon Pinpoint ID to associate with unique user IDs in the
    /// recommender model. This value enables the model to use attribute and event
    /// data that’s specific to a particular endpoint or user in an Amazon Pinpoint
    /// application. Valid values are:
    ///
    /// * PINPOINT_ENDPOINT_ID - Associate each user in the model with a particular
    ///   endpoint in Amazon Pinpoint. The data is correlated based on endpoint IDs
    ///   in Amazon Pinpoint. This is the default value.
    /// * PINPOINT_USER_ID - Associate each user in the model with a particular user
    ///   and endpoint in Amazon Pinpoint. The data is correlated based on user IDs
    ///   in Amazon Pinpoint. If you specify this value, an endpoint definition in
    ///   Amazon Pinpoint has to specify both a user ID (UserId) and an endpoint ID.
    ///   Otherwise, messages won’t be sent to the user's endpoint.
    recommendation_provider_id_type: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the AWS Identity and Access Management
    /// (IAM) role that authorizes Amazon Pinpoint to retrieve recommendation data
    /// from the recommender model.
    recommendation_provider_role_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the recommender model to retrieve
    /// recommendation data from. This value must match the ARN of an Amazon
    /// Personalize campaign.
    recommendation_provider_uri: []const u8,

    /// A custom display name for the standard endpoint or user attribute
    /// (RecommendationItems) that temporarily stores recommended items for each
    /// endpoint or user, depending on the value for the
    /// RecommendationProviderIdType property. This value is required if the
    /// configuration doesn't invoke an AWS Lambda function
    /// (RecommendationTransformerUri) to perform additional processing of
    /// recommendation data.
    ///
    /// This name appears in the **Attribute finder** of the template editor on the
    /// Amazon Pinpoint console. The name can contain up to 25 characters. The
    /// characters can be letters, numbers, spaces, underscores (_), or hyphens (-).
    /// These restrictions don't apply to attribute values.
    recommendations_display_name: ?[]const u8,

    /// The number of recommended items to retrieve from the model for each endpoint
    /// or user, depending on the value for the RecommendationProviderIdType
    /// property. This number determines how many recommended items are available
    /// for use in message variables. The minimum value is 1. The maximum value is
    /// 5. The default value is 5.
    ///
    /// To use multiple recommended items and custom attributes with message
    /// variables, you have to use an AWS Lambda function
    /// (RecommendationTransformerUri) to perform additional processing of
    /// recommendation data.
    recommendations_per_message: ?i32,

    /// The name or Amazon Resource Name (ARN) of the AWS Lambda function to invoke
    /// for additional processing of recommendation data that's retrieved from the
    /// recommender model.
    recommendation_transformer_uri: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .description = "Description",
        .name = "Name",
        .recommendation_provider_id_type = "RecommendationProviderIdType",
        .recommendation_provider_role_arn = "RecommendationProviderRoleArn",
        .recommendation_provider_uri = "RecommendationProviderUri",
        .recommendations_display_name = "RecommendationsDisplayName",
        .recommendations_per_message = "RecommendationsPerMessage",
        .recommendation_transformer_uri = "RecommendationTransformerUri",
    };
};
