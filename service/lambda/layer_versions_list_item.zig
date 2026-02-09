const Architecture = @import("architecture.zig").Architecture;
const Runtime = @import("runtime.zig").Runtime;

/// Details about a version of an [Lambda
/// layer](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html).
pub const LayerVersionsListItem = struct {
    /// A list of compatible [instruction set
    /// architectures](https://docs.aws.amazon.com/lambda/latest/dg/foundation-arch.html).
    compatible_architectures: ?[]const Architecture,

    /// The layer's compatible runtimes.
    ///
    /// The following list includes deprecated runtimes. For more information, see
    /// [Runtime use after
    /// deprecation](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html#runtime-deprecation-levels).
    ///
    /// For a list of all currently supported runtimes, see [Supported
    /// runtimes](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html#runtimes-supported).
    compatible_runtimes: ?[]const Runtime,

    /// The date that the version was created, in ISO 8601 format. For example,
    /// `2018-11-27T15:10:45.123+0000`.
    created_date: ?[]const u8,

    /// The description of the version.
    description: ?[]const u8,

    /// The ARN of the layer version.
    layer_version_arn: ?[]const u8,

    /// The layer's open-source license.
    license_info: ?[]const u8,

    /// The version number.
    version: ?i64,
};
