const aws = @import("aws");

const Scope = @import("scope.zig").Scope;

/// This parameter is specified when you're using Docker volumes. Docker volumes
/// are only supported when you're using the EC2 launch type. Windows containers
/// only support the use of the `local` driver. To use bind mounts, specify a
/// `host` instead.
pub const DockerVolumeConfiguration = struct {
    /// If this value is `true`, the Docker volume is created if it doesn't already
    /// exist.
    ///
    /// This field is only used if the `scope` is `shared`.
    autoprovision: ?bool = null,

    /// The Docker volume driver to use. The driver value must match the driver name
    /// provided by Docker because it is used for task placement. If the driver was
    /// installed using the Docker plugin CLI, use `docker plugin ls` to retrieve
    /// the driver name from your container instance. If the driver was installed
    /// using another method, use Docker plugin discovery to retrieve the driver
    /// name. This parameter maps to `Driver` in the docker container create command
    /// and the `xxdriver` option to docker volume create.
    driver: ?[]const u8 = null,

    /// A map of Docker driver-specific options passed through. This parameter maps
    /// to `DriverOpts` in the docker create-volume command and the `xxopt` option
    /// to docker volume create.
    driver_opts: ?[]const aws.map.StringMapEntry = null,

    /// Custom metadata to add to your Docker volume. This parameter maps to
    /// `Labels` in the docker container create command and the `xxlabel` option to
    /// docker volume create.
    labels: ?[]const aws.map.StringMapEntry = null,

    /// The scope for the Docker volume that determines its lifecycle. Docker
    /// volumes that are scoped to a `task` are automatically provisioned when the
    /// task starts and destroyed when the task stops. Docker volumes that are
    /// scoped as `shared` persist after the task stops.
    scope: ?Scope = null,

    pub const json_field_names = .{
        .autoprovision = "autoprovision",
        .driver = "driver",
        .driver_opts = "driverOpts",
        .labels = "labels",
        .scope = "scope",
    };
};
