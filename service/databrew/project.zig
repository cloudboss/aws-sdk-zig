const aws = @import("aws");

const Sample = @import("sample.zig").Sample;

/// Represents all of the attributes of a DataBrew project.
pub const Project = struct {
    /// The ID of the Amazon Web Services account that owns the project.
    account_id: ?[]const u8,

    /// The date and time that the project was created.
    create_date: ?i64,

    /// The Amazon Resource Name (ARN) of the user who crated the project.
    created_by: ?[]const u8,

    /// The dataset that the project is to act upon.
    dataset_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the user who last modified the project.
    last_modified_by: ?[]const u8,

    /// The last modification date and time for the project.
    last_modified_date: ?i64,

    /// The unique name of a project.
    name: []const u8,

    /// The date and time when the project was opened.
    open_date: ?i64,

    /// The Amazon Resource Name (ARN) of the user that opened the project for use.
    opened_by: ?[]const u8,

    /// The name of a recipe that will be developed during a project session.
    recipe_name: []const u8,

    /// The Amazon Resource Name (ARN) for the project.
    resource_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the role that will be assumed for this
    /// project.
    role_arn: ?[]const u8,

    /// The sample size and sampling type to apply to the data. If this parameter
    /// isn't
    /// specified, then the sample consists of the first 500 rows from the dataset.
    sample: ?Sample,

    /// Metadata tags that have been applied to the project.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .create_date = "CreateDate",
        .created_by = "CreatedBy",
        .dataset_name = "DatasetName",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .open_date = "OpenDate",
        .opened_by = "OpenedBy",
        .recipe_name = "RecipeName",
        .resource_arn = "ResourceArn",
        .role_arn = "RoleArn",
        .sample = "Sample",
        .tags = "Tags",
    };
};
