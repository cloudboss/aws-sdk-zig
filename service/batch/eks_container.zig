const EksContainerEnvironmentVariable = @import("eks_container_environment_variable.zig").EksContainerEnvironmentVariable;
const EksContainerResourceRequirements = @import("eks_container_resource_requirements.zig").EksContainerResourceRequirements;
const EksContainerSecurityContext = @import("eks_container_security_context.zig").EksContainerSecurityContext;
const EksContainerVolumeMount = @import("eks_container_volume_mount.zig").EksContainerVolumeMount;

/// EKS container properties are used in job definitions for Amazon EKS based
/// job definitions to
/// describe the properties for a container node in the pod that's launched as
/// part of a job. This
/// can't be specified for Amazon ECS based job definitions.
pub const EksContainer = struct {
    /// An array of arguments to the entrypoint. If this isn't specified, the `CMD`
    /// of
    /// the container image is used. This corresponds to the `args` member in the
    /// [Entrypoint](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#entrypoint) portion of the [Pod](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/)
    /// in Kubernetes. Environment variable references are expanded using the
    /// container's environment.
    ///
    /// If the referenced environment variable doesn't exist, the reference in the
    /// command isn't
    /// changed. For example, if the reference is to "`$(NAME1)`" and the `NAME1`
    /// environment variable doesn't exist, the command string will remain
    /// "`$(NAME1)`."
    /// `$$` is replaced with `$`, and the resulting string isn't expanded. For
    /// example, `$$(VAR_NAME)` is passed as `$(VAR_NAME)` whether or not the
    /// `VAR_NAME` environment variable exists. For more information, see
    /// [Dockerfile reference:
    /// CMD](https://docs.docker.com/engine/reference/builder/#cmd)
    /// and [Define a command and arguments for a
    /// pod](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/) in the *Kubernetes
    /// documentation*.
    args: ?[]const []const u8,

    /// The entrypoint for the container. This isn't run within a shell. If this
    /// isn't specified,
    /// the `ENTRYPOINT` of the container image is used. Environment variable
    /// references are
    /// expanded using the container's environment.
    ///
    /// If the referenced environment variable doesn't exist, the reference in the
    /// command isn't
    /// changed. For example, if the reference is to "`$(NAME1)`" and the `NAME1`
    /// environment variable doesn't exist, the command string will remain
    /// "`$(NAME1)`."
    /// `$$` is replaced with `$` and the resulting string isn't expanded. For
    /// example, `$$(VAR_NAME)` will be passed as `$(VAR_NAME)` whether or not the
    /// `VAR_NAME` environment variable exists. The entrypoint can't be updated. For
    /// more
    /// information, see
    /// [ENTRYPOINT](https://docs.docker.com/engine/reference/builder/#entrypoint)
    /// in the *Dockerfile reference* and [Define a command and arguments for a
    /// container](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/) and [Entrypoint](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#entrypoint) in the *Kubernetes documentation*.
    command: ?[]const []const u8,

    /// The environment variables to pass to a container.
    ///
    /// Environment variables cannot start with "`AWS_BATCH`". This naming
    /// convention is reserved for variables that Batch sets.
    env: ?[]const EksContainerEnvironmentVariable,

    /// The Docker image used to start the container.
    image: []const u8,

    /// The image pull policy for the container. Supported values are `Always`,
    /// `IfNotPresent`, and `Never`. This parameter defaults to
    /// `IfNotPresent`. However, if the `:latest` tag is specified, it defaults to
    /// `Always`. For more information, see [Updating
    /// images](https://kubernetes.io/docs/concepts/containers/images/#updating-images) in the *Kubernetes documentation*.
    image_pull_policy: ?[]const u8,

    /// The name of the container. If the name isn't specified, the default name
    /// "`Default`" is used. Each container in a pod must have a unique name.
    name: ?[]const u8,

    /// The type and amount of resources to assign to a container. The supported
    /// resources include
    /// `memory`, `cpu`, and `nvidia.com/gpu`. For more information,
    /// see [Resource management for pods and
    /// containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) in the *Kubernetes
    /// documentation*.
    resources: ?EksContainerResourceRequirements,

    /// The security context for a job. For more information, see [Configure a
    /// security context for a pod or
    /// container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) in the *Kubernetes
    /// documentation*.
    security_context: ?EksContainerSecurityContext,

    /// The volume mounts for the container. Batch supports `emptyDir`,
    /// `hostPath`, and `secret` volume types. For more information about volumes
    /// and volume mounts in Kubernetes, see
    /// [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/) in the
    /// *Kubernetes documentation*.
    volume_mounts: ?[]const EksContainerVolumeMount,

    pub const json_field_names = .{
        .args = "args",
        .command = "command",
        .env = "env",
        .image = "image",
        .image_pull_policy = "imagePullPolicy",
        .name = "name",
        .resources = "resources",
        .security_context = "securityContext",
        .volume_mounts = "volumeMounts",
    };
};
