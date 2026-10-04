const ImageBuildConfiguration = @import("image_build_configuration.zig").ImageBuildConfiguration;
const ImageSource = @import("image_source.zig").ImageSource;

/// The source of the container image for an application version: an image that
/// you built and
/// pushed to a container registry yourself, or settings for Elastic Beanstalk
/// to build one from your source
/// bundle.
pub const ImageConfiguration = struct {
    /// Settings that Elastic Beanstalk uses to build a container image from the
    /// source bundle of the
    /// application version.
    ///
    /// If you specify `Build`, also specify the request's `SourceBundle`
    /// parameter, and don't specify `Source`.
    build: ?ImageBuildConfiguration = null,

    /// The location of a container image that you built and pushed to a container
    /// registry
    /// yourself. Elastic Beanstalk deploys the image without a build step.
    ///
    /// If you specify `Source`, don't specify `Build` or the request's
    /// `SourceBundle` parameter.
    source: ?ImageSource = null,
};
