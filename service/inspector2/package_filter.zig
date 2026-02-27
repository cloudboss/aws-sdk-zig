const StringFilter = @import("string_filter.zig").StringFilter;
const NumberFilter = @import("number_filter.zig").NumberFilter;

/// Contains information on the details of a package filter.
pub const PackageFilter = struct {
    /// An object that contains details on the package architecture type to filter
    /// on.
    architecture: ?StringFilter,

    /// An object that contains details on the package epoch to filter on.
    epoch: ?NumberFilter,

    /// An object that contains details on the package file path to filter on.
    file_path: ?StringFilter,

    /// An object that contains details on the name of the package to filter on.
    name: ?StringFilter,

    /// An object that contains details on the package release to filter on.
    release: ?StringFilter,

    /// An object that describes the details of a string filter.
    source_lambda_layer_arn: ?StringFilter,

    /// An object that contains details on the source layer hash to filter on.
    source_layer_hash: ?StringFilter,

    /// The package version to filter on.
    version: ?StringFilter,

    pub const json_field_names = .{
        .architecture = "architecture",
        .epoch = "epoch",
        .file_path = "filePath",
        .name = "name",
        .release = "release",
        .source_lambda_layer_arn = "sourceLambdaLayerArn",
        .source_layer_hash = "sourceLayerHash",
        .version = "version",
    };
};
