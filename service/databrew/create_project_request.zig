const aws = @import("aws");

const Sample = @import("sample.zig").Sample;

pub const CreateProjectRequest = struct {
    /// The name of an existing dataset to associate this project with.
    dataset_name: []const u8,

    /// A unique name for the new project. Valid characters are alphanumeric (A-Z,
    /// a-z, 0-9),
    /// hyphen (-), period (.), and space.
    name: []const u8,

    /// The name of an existing recipe to associate with the project.
    recipe_name: []const u8,

    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role to
    /// be assumed for this request.
    role_arn: []const u8,

    sample: ?Sample,

    /// Metadata tags to apply to this project.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .dataset_name = "DatasetName",
        .name = "Name",
        .recipe_name = "RecipeName",
        .role_arn = "RoleArn",
        .sample = "Sample",
        .tags = "Tags",
    };
};
