/// Provides information about a recipe. Each recipe provides an algorithm
/// that Amazon Personalize uses in model training when you use the
/// [CreateSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSolution.html)
/// operation.
pub const Recipe = struct {
    /// The Amazon Resource Name (ARN) of the algorithm that Amazon Personalize uses
    /// to train
    /// the model.
    algorithm_arn: ?[]const u8 = null,

    /// The date and time (in Unix format) that the recipe was created.
    creation_date_time: ?i64 = null,

    /// The description of the recipe.
    description: ?[]const u8 = null,

    /// The ARN of the FeatureTransformation object.
    feature_transformation_arn: ?[]const u8 = null,

    /// The date and time (in Unix format) that the recipe was last updated.
    last_updated_date_time: ?i64 = null,

    /// The name of the recipe.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the recipe.
    recipe_arn: ?[]const u8 = null,

    /// One of the following values:
    ///
    /// * PERSONALIZED_RANKING
    ///
    /// * RELATED_ITEMS
    ///
    /// * USER_PERSONALIZATION
    recipe_type: ?[]const u8 = null,

    /// The status of the recipe.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .algorithm_arn = "algorithmArn",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .feature_transformation_arn = "featureTransformationArn",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .recipe_arn = "recipeArn",
        .recipe_type = "recipeType",
        .status = "status",
    };
};
