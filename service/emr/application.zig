const aws = @import("aws");

/// With Amazon EMR release version 4.0 and later, the only accepted parameter
/// is
/// the application name. To pass arguments to applications, you use
/// configuration
/// classifications specified using configuration JSON objects. For more
/// information, see
/// [Configuring
/// Applications](https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-configure-apps.html).
///
/// With earlier Amazon EMR releases, the application is any Amazon or
/// third-party
/// software that you can add to the cluster. This structure contains a list of
/// strings that
/// indicates the software to use with the cluster and accepts a user argument
/// list. Amazon EMR accepts and forwards the argument list to the corresponding
/// installation
/// script as bootstrap action argument.
pub const Application = struct {
    /// This option is for advanced users only. This is meta information about
    /// third-party
    /// applications that third-party vendors use for testing purposes.
    additional_info: ?[]const aws.map.StringMapEntry = null,

    /// Arguments for Amazon EMR to pass to the application.
    args: ?[]const []const u8 = null,

    /// The name of the application.
    name: ?[]const u8 = null,

    /// The version of the application.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_info = "AdditionalInfo",
        .args = "Args",
        .name = "Name",
        .version = "Version",
    };
};
