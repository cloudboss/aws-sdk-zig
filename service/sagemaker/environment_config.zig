const FSxLustreConfig = @import("f_sx_lustre_config.zig").FSxLustreConfig;

/// The configuration for the restricted instance groups (RIG) environment.
pub const EnvironmentConfig = struct {
    /// Configuration settings for an Amazon FSx for Lustre file system to be used
    /// with the cluster.
    f_sx_lustre_config: ?FSxLustreConfig = null,

    pub const json_field_names = .{
        .f_sx_lustre_config = "FSxLustreConfig",
    };
};
