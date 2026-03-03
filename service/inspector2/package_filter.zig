const StringFilter = @import("string_filter.zig").StringFilter;
const NumberFilter = @import("number_filter.zig").NumberFilter;

/// Contains information on the details of a package filter.
pub const PackageFilter = struct {
    /// An object that contains details on the package architecture type to filter
    /// on.
    architecture: ?StringFilter = null,

    /// An object that contains details on the package epoch to filter on.
    epoch: ?NumberFilter = null,

    /// An object that contains details on the package file path to filter on.
    file_path: ?StringFilter = null,

    /// An object that contains details on the name of the package to filter on.
    name: ?StringFilter = null,

    /// An object that contains details on the package release to filter on.
    release: ?StringFilter = null,

    /// An object that describes the details of a string filter.
    source_lambda_layer_arn: ?StringFilter = null,

    /// An object that contains details on the source layer hash to filter on.
    source_layer_hash: ?StringFilter = null,

    /// The package version to filter on.
    version: ?StringFilter = null,

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
