const aws = @import("aws");

const RecipeStep = @import("recipe_step.zig").RecipeStep;

/// Represents one or more actions to be performed on a DataBrew dataset.
pub const Recipe = struct {
    /// The date and time that the recipe was created.
    create_date: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the user who created the recipe.
    created_by: ?[]const u8 = null,

    /// The description of the recipe.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the user who last modified the recipe.
    last_modified_by: ?[]const u8 = null,

    /// The last modification date and time of the recipe.
    last_modified_date: ?i64 = null,

    /// The unique name for the recipe.
    name: []const u8,

    /// The name of the project that the recipe is associated with.
    project_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the user who published the recipe.
    published_by: ?[]const u8 = null,

    /// The date and time when the recipe was published.
    published_date: ?i64 = null,

    /// The identifier for the version for the recipe. Must be one of the following:
    ///
    /// * Numeric version (`X.Y`) - `X` and `Y` stand
    /// for major and minor version numbers. The maximum length of each is 6 digits,
    /// and
    /// neither can be negative values. Both `X` and `Y` are
    /// required, and "0.0" isn't a valid version.
    ///
    /// * `LATEST_WORKING` - the most recent valid version being developed in
    /// a DataBrew project.
    ///
    /// * `LATEST_PUBLISHED` - the most recent published version.
    recipe_version: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the recipe.
    resource_arn: ?[]const u8 = null,

    /// A list of steps that are defined by the recipe.
    steps: ?[]const RecipeStep = null,

    /// Metadata tags that have been applied to the recipe.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .create_date = "CreateDate",
        .created_by = "CreatedBy",
        .description = "Description",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .project_name = "ProjectName",
        .published_by = "PublishedBy",
        .published_date = "PublishedDate",
        .recipe_version = "RecipeVersion",
        .resource_arn = "ResourceArn",
        .steps = "Steps",
        .tags = "Tags",
    };
};
