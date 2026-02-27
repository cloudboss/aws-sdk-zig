const SourceBuildInformation = @import("source_build_information.zig").SourceBuildInformation;
const S3Location = @import("s3_location.zig").S3Location;
const ApplicationVersionStatus = @import("application_version_status.zig").ApplicationVersionStatus;

/// Describes the properties of an application version.
pub const ApplicationVersionDescription = struct {
    /// The name of the application to which the application version belongs.
    application_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the application version.
    application_version_arn: ?[]const u8,

    /// Reference to the artifact from the AWS CodeBuild build.
    build_arn: ?[]const u8,

    /// The creation date of the application version.
    date_created: ?i64,

    /// The last modified date of the application version.
    date_updated: ?i64,

    /// The description of the application version.
    description: ?[]const u8,

    /// If the version's source code was retrieved from AWS CodeCommit, the location
    /// of the
    /// source code for the application version.
    source_build_information: ?SourceBuildInformation,

    /// The storage location of the application version's source bundle in Amazon
    /// S3.
    source_bundle: ?S3Location,

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
    /// * `Building` – Application version is currently undergoing an AWS CodeBuild
    ///   build.
    ///
    /// * `Processed` – Elastic Beanstalk was successfully pre-processed and
    ///   validated.
    ///
    /// * `Failed` – Either the AWS CodeBuild build failed or configuration files
    ///   didn't
    /// pass validation. This application version isn't usable.
    status: ?ApplicationVersionStatus,

    /// A unique identifier for the application version.
    version_label: ?[]const u8,
};
