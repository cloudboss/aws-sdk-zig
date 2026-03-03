/// Custom libraries to be loaded into a development endpoint.
pub const DevEndpointCustomLibraries = struct {
    /// The path to one or more Java `.jar` files in an S3 bucket that should be
    /// loaded
    /// in your `DevEndpoint`.
    ///
    /// You can only use pure Java/Scala libraries with a `DevEndpoint`.
    extra_jars_s3_path: ?[]const u8 = null,

    /// The paths to one or more Python libraries in an Amazon Simple Storage
    /// Service (Amazon S3)
    /// bucket that should be loaded in your `DevEndpoint`. Multiple values must be
    /// complete paths separated by a comma.
    ///
    /// You can only use pure Python libraries with a `DevEndpoint`. Libraries that
    /// rely on
    /// C extensions, such as the [pandas](http://pandas.pydata.org/) Python data
    /// analysis library, are not currently supported.
    extra_python_libs_s3_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .extra_jars_s3_path = "ExtraJarsS3Path",
        .extra_python_libs_s3_path = "ExtraPythonLibsS3Path",
    };
};
