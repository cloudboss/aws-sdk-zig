/// Provides a summary of the properties of a solution. For a complete listing,
/// call the
/// [DescribeSolution](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSolution.html) API.
pub const SolutionSummary = struct {
    /// The date and time (in Unix time) that the solution was created.
    creation_date_time: ?i64,

    /// The date and time (in Unix time) that the solution was last updated.
    last_updated_date_time: ?i64,

    /// The name of the solution.
    name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the recipe used by the solution.
    recipe_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the solution.
    solution_arn: ?[]const u8,

    /// The status of the solution.
    ///
    /// A solution can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    ///
    /// * DELETE PENDING > DELETE IN_PROGRESS
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .recipe_arn = "recipeArn",
        .solution_arn = "solutionArn",
        .status = "status",
    };
};
