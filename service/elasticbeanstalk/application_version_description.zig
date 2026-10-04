const ImageBuildConfiguration = @import("image_build_configuration.zig").ImageBuildConfiguration;
const ImageSource = @import("image_source.zig").ImageSource;
const SourceBuildInformation = @import("source_build_information.zig").SourceBuildInformation;
const S3Location = @import("s3_location.zig").S3Location;
const ApplicationVersionStatus = @import("application_version_status.zig").ApplicationVersionStatus;

/// Describes the properties of an application version.
pub const ApplicationVersionDescription = struct {
    /// The name of the application to which the application version belongs.
    application_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the application version.
    application_version_arn: ?[]const u8 = null,

    /// Reference to the artifact from the CodeBuild build.
    build_arn: ?[]const u8 = null,

    /// The creation date of the application version.
    date_created: ?i64 = null,

    /// The last modified date of the application version.
    date_updated: ?i64 = null,

    /// The description of the application version.
    description: ?[]const u8 = null,

    /// The settings that Elastic Beanstalk uses to build a container image from the
    /// source bundle of the
    /// application version. Not present for an application version created from an
    /// image you
    /// provide.
    image_build_configuration: ?ImageBuildConfiguration = null,

    /// The location of the container image for the application version.
    ///
    /// For an application version created from an image you provide, this is that
    /// image. For one
    /// that Elastic Beanstalk builds from your source bundle, Elastic Beanstalk
    /// fills this in with the image it pushed after
    /// the build succeeds.
    image_source: ?ImageSource = null,

    /// Indicates whether Elastic Beanstalk pre-processed and validated the
    /// environment manifest
    /// (`env.yaml`) and configuration files (`*.config` files in the
    /// `.ebextensions` folder) in the source bundle of the application version.
    process: ?bool = null,

    /// If the version's source code was retrieved from CodeCommit, the location of
    /// the
    /// source code for the application version.
    source_build_information: ?SourceBuildInformation = null,

    /// The storage location of the application version's source bundle in Amazon
    /// S3.
    source_bundle: ?S3Location = null,

    /// The processing status of the application version. Reflects the state of the
    /// application
    /// version during its creation. Many of the values are only applicable if you
    /// specified
    /// `True` for the `Process` parameter of the
    /// `CreateApplicationVersion` action. The following list describes the possible
    /// values.
    ///
    /// * `Unprocessed` – Application version wasn't pre-processed or validated.
    /// Elastic Beanstalk will validate configuration files during deployment of the
    /// application version to an
    /// environment.
    ///
    /// * `Processing` – Elastic Beanstalk is currently processing the application
    ///   version.
    ///
    /// * `Building` – Application version is currently undergoing an CodeBuild
    ///   build.
    ///
    /// * `Processed` – Elastic Beanstalk was successfully pre-processed and
    ///   validated.
    ///
    /// * `Failed` – Either the CodeBuild build failed or configuration files didn't
    /// pass validation. This application version isn't usable.
    status: ?ApplicationVersionStatus = null,

    /// A unique identifier for the application version.
    version_label: ?[]const u8 = null,
};
