const aws = @import("aws");

/// Information about a Docker volume.
pub const AwsEcsTaskDefinitionVolumesDockerVolumeConfigurationDetails = struct {
    /// Whether to create the Docker volume automatically if it does not already
    /// exist.
    autoprovision: ?bool,

    /// The Docker volume driver to use.
    driver: ?[]const u8,

    /// A map of Docker driver-specific options that are passed through.
    driver_opts: ?[]const aws.map.StringMapEntry,

    /// Custom metadata to add to the Docker volume.
    labels: ?[]const aws.map.StringMapEntry,

    /// The scope for the Docker volume that determines its lifecycle. Docker
    /// volumes that are scoped to a task are provisioned
    /// automatically when the task starts and destroyed when the task stops. Docker
    /// volumes that are shared persist after the task stops. Valid values are
    /// `shared` or `task`.
    scope: ?[]const u8,

    pub const json_field_names = .{
        .autoprovision = "Autoprovision",
        .driver = "Driver",
        .driver_opts = "DriverOpts",
        .labels = "Labels",
        .scope = "Scope",
    };
};
