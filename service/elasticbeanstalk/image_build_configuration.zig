const ArchitectureType = @import("architecture_type.zig").ArchitectureType;
const ComputeType = @import("compute_type.zig").ComputeType;
const ImageBuildType = @import("image_build_type.zig").ImageBuildType;

/// Settings that Elastic Beanstalk uses to build a container image from the
/// source bundle of an
/// application version.
pub const ImageBuildConfiguration = struct {
    /// The processor architecture that Elastic Beanstalk builds the container image
    /// for. The architecture must
    /// match the architecture of the instances in the environment that you deploy
    /// the application
    /// version to.
    ///
    /// Valid values:
    ///
    /// * `amd64` – x86-64 instances. This is the default.
    ///
    /// * `arm64` – Amazon Web Services Graviton instances.
    architecture: ?ArchitectureType = null,

    /// The Cloud Native Buildpacks builder image that Elastic Beanstalk uses to
    /// build the container image. For
    /// example, `paketobuildpacks/builder-jammy-base`.
    ///
    /// This member is required when `Type` is `buildpack`. Elastic Beanstalk
    /// doesn't
    /// provide a default builder.
    buildpack: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role that CodeBuild assumes to run
    /// the build in your Amazon Web Services account. Elastic Beanstalk rejects a
    /// `Build` that doesn't specify this
    /// role.
    code_build_service_role: ?[]const u8 = null,

    /// The size of the compute resources that run the build. If you don't specify
    /// it, Elastic Beanstalk uses
    /// `BUILD_GENERAL1_MEDIUM`.
    ///
    /// Valid values:
    ///
    /// * `BUILD_GENERAL1_SMALL` – Use up to 3 GB memory and 2 vCPUs for
    /// builds.
    ///
    /// * `BUILD_GENERAL1_MEDIUM` – Use up to 7 GB memory and 4 vCPUs for
    /// builds.
    ///
    /// * `BUILD_GENERAL1_LARGE` – Use up to 15 GB memory and 8 vCPUs for
    /// builds.
    compute_type: ?ComputeType = null,

    /// The path to the Dockerfile within the source bundle, relative to the root of
    /// the source
    /// bundle. For example, `backend/Dockerfile`.
    ///
    /// Elastic Beanstalk uses this member only when `Type` is `docker`. If you
    /// don't
    /// specify it, Elastic Beanstalk uses the Dockerfile at the root of the source
    /// bundle.
    dockerfile_location: ?[]const u8 = null,

    /// How long, in minutes from 5 to 480 (8 hours), Elastic Beanstalk waits before
    /// stopping a build that
    /// hasn't completed. The default is 60 minutes.
    timeout_in_minutes: ?i32 = null,

    /// How Elastic Beanstalk builds the container image. Elastic Beanstalk rejects
    /// a `Build` that doesn't
    /// specify it.
    ///
    /// Valid values:
    ///
    /// * `docker` – Elastic Beanstalk builds the image from a Dockerfile in your
    ///   source
    /// bundle. Specify the Dockerfile with `DockerfileLocation`.
    ///
    /// * `buildpack` – Elastic Beanstalk builds the image with a Cloud Native
    ///   Buildpacks
    /// builder. Specify the builder with `Buildpack`.
    @"type": ?ImageBuildType = null,
};
