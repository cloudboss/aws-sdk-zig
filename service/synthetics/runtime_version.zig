/// This structure contains information about one canary runtime version. For
/// more information about
/// runtime versions, see [
/// Canary Runtime
/// Versions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_Library.html).
pub const RuntimeVersion = struct {
    /// If this runtime version is deprecated, this value is the date of
    /// deprecation.
    deprecation_date: ?i64 = null,

    /// A description of the runtime version, created by Amazon.
    description: ?[]const u8 = null,

    /// The date that the runtime version was released.
    release_date: ?i64 = null,

    /// The name of the runtime version. For a list of valid runtime versions,
    /// see [
    /// Canary Runtime
    /// Versions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_Library.html).
    version_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .deprecation_date = "DeprecationDate",
        .description = "Description",
        .release_date = "ReleaseDate",
        .version_name = "VersionName",
    };
};
