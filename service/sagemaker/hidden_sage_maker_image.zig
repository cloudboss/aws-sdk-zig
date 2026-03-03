const SageMakerImageName = @import("sage_maker_image_name.zig").SageMakerImageName;

/// The SageMaker images that are hidden from the Studio user interface. You
/// must specify the SageMaker image name and version aliases.
pub const HiddenSageMakerImage = struct {
    /// The SageMaker image name that you are hiding from the Studio user interface.
    sage_maker_image_name: ?SageMakerImageName = null,

    /// The version aliases you are hiding from the Studio user interface.
    version_aliases: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .sage_maker_image_name = "SageMakerImageName",
        .version_aliases = "VersionAliases",
    };
};
