const FSxLustreConfig = @import("f_sx_lustre_config.zig").FSxLustreConfig;

/// The configuration details for the restricted instance groups (RIG)
/// environment.
pub const EnvironmentConfigDetails = struct {
    /// Configuration settings for an Amazon FSx for Lustre file system to be used
    /// with the cluster.
    f_sx_lustre_config: ?FSxLustreConfig,

    /// The Amazon S3 path where output data from the restricted instance group
    /// (RIG) environment will be stored.
    s3_output_path: ?[]const u8,

    pub const json_field_names = .{
        .f_sx_lustre_config = "FSxLustreConfig",
        .s3_output_path = "S3OutputPath",
    };
};
