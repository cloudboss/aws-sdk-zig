/// A link to another environment, defined in the environment's manifest. Links
/// provide
/// connection information in system properties that can be used to connect to
/// another environment
/// in the same group. See [Environment Manifest
/// (env.yaml)](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environment-cfg-manifest.html) for details.
pub const EnvironmentLink = struct {
    /// The name of the linked environment (the dependency).
    environment_name: ?[]const u8,

    /// The name of the link.
    link_name: ?[]const u8,
};
