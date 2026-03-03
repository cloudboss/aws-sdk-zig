const aws = @import("aws");

const ConfigurationObject = @import("configuration_object.zig").ConfigurationObject;

/// Specifies the job and session values that an admin configures in an Glue
/// usage profile.
pub const ProfileConfiguration = struct {
    /// A key-value map of configuration parameters for Glue jobs.
    job_configuration: ?[]const aws.map.MapEntry(ConfigurationObject) = null,

    /// A key-value map of configuration parameters for Glue sessions.
    session_configuration: ?[]const aws.map.MapEntry(ConfigurationObject) = null,

    pub const json_field_names = .{
        .job_configuration = "JobConfiguration",
        .session_configuration = "SessionConfiguration",
    };
};
