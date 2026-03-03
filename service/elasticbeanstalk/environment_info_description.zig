const EnvironmentInfoType = @import("environment_info_type.zig").EnvironmentInfoType;

/// The information retrieved from the Amazon EC2 instances.
pub const EnvironmentInfoDescription = struct {
    /// The Amazon EC2 Instance ID for this information.
    ec_2_instance_id: ?[]const u8 = null,

    /// The type of information retrieved.
    info_type: ?EnvironmentInfoType = null,

    /// The retrieved information. Currently contains a presigned Amazon S3 URL. The
    /// files are
    /// deleted after 15 minutes.
    ///
    /// Anyone in possession of this URL can access the files before they are
    /// deleted. Make the
    /// URL available only to trusted parties.
    message: ?[]const u8 = null,

    /// The time stamp when this information was retrieved.
    sample_timestamp: ?i64 = null,
};
