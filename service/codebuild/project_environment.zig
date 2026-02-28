const ComputeConfiguration = @import("compute_configuration.zig").ComputeConfiguration;
const ComputeType = @import("compute_type.zig").ComputeType;
const DockerServer = @import("docker_server.zig").DockerServer;
const EnvironmentVariable = @import("environment_variable.zig").EnvironmentVariable;
const ProjectFleet = @import("project_fleet.zig").ProjectFleet;
const ImagePullCredentialsType = @import("image_pull_credentials_type.zig").ImagePullCredentialsType;
const RegistryCredential = @import("registry_credential.zig").RegistryCredential;
const EnvironmentType = @import("environment_type.zig").EnvironmentType;

/// Information about the build environment of the build project.
pub const ProjectEnvironment = struct {
    /// The ARN of the Amazon S3 bucket, path prefix, and object key that contains
    /// the PEM-encoded
    /// certificate for the build project. For more information, see
    /// [certificate](https://docs.aws.amazon.com/codebuild/latest/userguide/create-project-cli.html#cli.environment.certificate) in the
    /// *CodeBuild User Guide*.
    certificate: ?[]const u8,

    /// The compute configuration of the build project. This is only required if
    /// `computeType` is set to `ATTRIBUTE_BASED_COMPUTE`.
    compute_configuration: ?ComputeConfiguration,

    /// Information about the compute resources the build project uses. Available
    /// values
    /// include:
    ///
    /// * `ATTRIBUTE_BASED_COMPUTE`: Specify the amount of vCPUs, memory, disk
    ///   space, and the type of machine.
    ///
    /// If you use `ATTRIBUTE_BASED_COMPUTE`, you must define your attributes by
    /// using `computeConfiguration`. CodeBuild
    /// will select the cheapest instance that satisfies your specified attributes.
    /// For more information, see [Reserved capacity environment
    /// types](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html#environment-reserved-capacity.types) in the *CodeBuild User Guide*.
    ///
    /// * `BUILD_GENERAL1_SMALL`: Use up to 4 GiB memory and 2 vCPUs for
    /// builds.
    ///
    /// * `BUILD_GENERAL1_MEDIUM`: Use up to 8 GiB memory and 4 vCPUs for
    /// builds.
    ///
    /// * `BUILD_GENERAL1_LARGE`: Use up to 16 GiB memory and 8 vCPUs for
    /// builds, depending on your environment type.
    ///
    /// * `BUILD_GENERAL1_XLARGE`: Use up to 72 GiB memory and 36 vCPUs for
    /// builds, depending on your environment type.
    ///
    /// * `BUILD_GENERAL1_2XLARGE`: Use up to 144 GiB memory, 72 vCPUs, and
    /// 824 GB of SSD storage for builds. This compute type supports Docker images
    /// up to
    /// 100 GB uncompressed.
    ///
    /// * `BUILD_LAMBDA_1GB`: Use up to 1 GiB memory for
    /// builds. Only available for environment type `LINUX_LAMBDA_CONTAINER` and
    /// `ARM_LAMBDA_CONTAINER`.
    ///
    /// * `BUILD_LAMBDA_2GB`: Use up to 2 GiB memory for
    /// builds. Only available for environment type `LINUX_LAMBDA_CONTAINER` and
    /// `ARM_LAMBDA_CONTAINER`.
    ///
    /// * `BUILD_LAMBDA_4GB`: Use up to 4 GiB memory for
    /// builds. Only available for environment type `LINUX_LAMBDA_CONTAINER` and
    /// `ARM_LAMBDA_CONTAINER`.
    ///
    /// * `BUILD_LAMBDA_8GB`: Use up to 8 GiB memory for
    /// builds. Only available for environment type `LINUX_LAMBDA_CONTAINER` and
    /// `ARM_LAMBDA_CONTAINER`.
    ///
    /// * `BUILD_LAMBDA_10GB`: Use up to 10 GiB memory for
    /// builds. Only available for environment type `LINUX_LAMBDA_CONTAINER` and
    /// `ARM_LAMBDA_CONTAINER`.
    ///
    /// If you use `BUILD_GENERAL1_SMALL`:
    ///
    /// * For environment type `LINUX_CONTAINER`, you can use up to 4 GiB
    /// memory and 2 vCPUs for builds.
    ///
    /// * For environment type `LINUX_GPU_CONTAINER`, you can use up to 16
    /// GiB memory, 4 vCPUs, and 1 NVIDIA A10G Tensor Core GPU for builds.
    ///
    /// * For environment type `ARM_CONTAINER`, you can use up to 4 GiB
    /// memory and 2 vCPUs on ARM-based processors for builds.
    ///
    /// If you use `BUILD_GENERAL1_LARGE`:
    ///
    /// * For environment type `LINUX_CONTAINER`, you can use up to 16 GiB
    /// memory and 8 vCPUs for builds.
    ///
    /// * For environment type `LINUX_GPU_CONTAINER`, you can use up to 255
    /// GiB memory, 32 vCPUs, and 4 NVIDIA Tesla V100 GPUs for builds.
    ///
    /// * For environment type `ARM_CONTAINER`, you can use up to 16 GiB
    /// memory and 8 vCPUs on ARM-based processors for builds.
    ///
    /// For more information, see [On-demand environment
    /// types](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html#environment.types)
    /// in the *CodeBuild User Guide.*
    compute_type: ComputeType,

    /// A DockerServer object to use for this build project.
    docker_server: ?DockerServer,

    /// A set of environment variables to make available to builds for this build
    /// project.
    environment_variables: ?[]const EnvironmentVariable,

    /// A ProjectFleet object to use for this build project.
    fleet: ?ProjectFleet,

    /// The image tag or image digest that identifies the Docker image to use for
    /// this build
    /// project. Use the following formats:
    ///
    /// * For an image tag: `/:`. For
    /// example, in the Docker repository that CodeBuild uses to manage its Docker
    /// images, this would be `aws/codebuild/standard:4.0`.
    ///
    /// * For an image digest: `/@`.
    /// For example, to specify an image with the digest
    /// "sha256:cbbf2f9a99b47fc460d422812b6a5adff7dfee951d8fa2e4a98caa0382cfbdbf,"
    /// use
    /// `/@sha256:cbbf2f9a99b47fc460d422812b6a5adff7dfee951d8fa2e4a98caa0382cfbdbf`.
    ///
    /// For more information, see [Docker images provided by
    /// CodeBuild](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html) in the *CodeBuild user
    /// guide*.
    image: []const u8,

    /// The type of credentials CodeBuild uses to pull images in your build. There
    /// are two valid
    /// values:
    ///
    /// * `CODEBUILD` specifies that CodeBuild uses its own credentials.
    /// This requires that you modify your ECR repository policy to trust CodeBuild
    /// service principal.
    ///
    /// * `SERVICE_ROLE` specifies that CodeBuild uses your build project's service
    /// role.
    ///
    /// When you use a cross-account or private registry image, you must use
    /// SERVICE_ROLE
    /// credentials. When you use an CodeBuild curated image, you must use CODEBUILD
    /// credentials.
    image_pull_credentials_type: ?ImagePullCredentialsType,

    /// Enables running the Docker daemon inside a Docker container. Set to true
    /// only if the
    /// build project is used to build Docker images. Otherwise, a build that
    /// attempts to
    /// interact with the Docker daemon fails. The default setting is `false`.
    ///
    /// You can initialize the Docker daemon during the install phase of your build
    /// by adding
    /// one of the following sets of commands to the install phase of your buildspec
    /// file:
    ///
    /// If the operating system's base image is Ubuntu Linux:
    ///
    /// `- nohup /usr/local/bin/dockerd --host=unix:///var/run/docker.sock
    /// --host=tcp://0.0.0.0:2375 --storage-driver=overlay&`
    ///
    /// `- timeout 15 sh -c "until docker info; do echo .; sleep 1; done"`
    ///
    /// If the operating system's base image is Alpine Linux and the previous
    /// command does not
    /// work, add the `-t` argument to `timeout`:
    ///
    /// `- nohup /usr/local/bin/dockerd --host=unix:///var/run/docker.sock
    /// --host=tcp://0.0.0.0:2375 --storage-driver=overlay&`
    ///
    /// `- timeout -t 15 sh -c "until docker info; do echo .; sleep 1; done"`
    privileged_mode: ?bool,

    /// The credentials for access to a private registry.
    registry_credential: ?RegistryCredential,

    /// The type of build environment to use for related builds.
    ///
    /// If you're using compute fleets during project creation, `type` will be
    /// ignored.
    ///
    /// For more information, see [Build environment compute
    /// types](https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-compute-types.html) in the *CodeBuild
    /// user guide*.
    type: EnvironmentType,

    pub const json_field_names = .{
        .certificate = "certificate",
        .compute_configuration = "computeConfiguration",
        .compute_type = "computeType",
        .docker_server = "dockerServer",
        .environment_variables = "environmentVariables",
        .fleet = "fleet",
        .image = "image",
        .image_pull_credentials_type = "imagePullCredentialsType",
        .privileged_mode = "privilegedMode",
        .registry_credential = "registryCredential",
        .type = "type",
    };
};
