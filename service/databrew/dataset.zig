const aws = @import("aws");

const InputFormat = @import("input_format.zig").InputFormat;
const FormatOptions = @import("format_options.zig").FormatOptions;
const Input = @import("input.zig").Input;
const PathOptions = @import("path_options.zig").PathOptions;
const Source = @import("source.zig").Source;

/// Represents a dataset that can be processed by DataBrew.
pub const Dataset = struct {
    /// The ID of the Amazon Web Services account that owns the dataset.
    account_id: ?[]const u8,

    /// The date and time that the dataset was created.
    create_date: ?i64,

    /// The Amazon Resource Name (ARN) of the user who created the dataset.
    created_by: ?[]const u8,

    /// The file format of a dataset that is created from an Amazon S3 file or
    /// folder.
    format: ?InputFormat,

    /// A set of options that define how DataBrew interprets the data in the
    /// dataset.
    format_options: ?FormatOptions,

    /// Information on how DataBrew can find the dataset, in either the Glue Data
    /// Catalog
    /// or Amazon S3.
    input: Input,

    /// The Amazon Resource Name (ARN) of the user who last modified the dataset.
    last_modified_by: ?[]const u8,

    /// The last modification date and time of the dataset.
    last_modified_date: ?i64,

    /// The unique name of the dataset.
    name: []const u8,

    /// A set of options that defines how DataBrew interprets an Amazon S3
    /// path of the dataset.
    path_options: ?PathOptions,

    /// The unique Amazon Resource Name (ARN) for the dataset.
    resource_arn: ?[]const u8,

    /// The location of the data for the dataset, either Amazon S3 or the Glue Data
    /// Catalog.
    source: ?Source,

    /// Metadata tags that have been applied to the dataset.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .create_date = "CreateDate",
        .created_by = "CreatedBy",
        .format = "Format",
        .format_options = "FormatOptions",
        .input = "Input",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .path_options = "PathOptions",
        .resource_arn = "ResourceArn",
        .source = "Source",
        .tags = "Tags",
    };
};
