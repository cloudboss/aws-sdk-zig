/// The `SessionCommand` that runs the job.
pub const SessionCommand = struct {
    /// Specifies the name of the SessionCommand. Can be 'glueetl' or
    /// 'gluestreaming'.
    name: ?[]const u8,

    /// Specifies the Python version. The Python version indicates the version
    /// supported for jobs of type Spark.
    python_version: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .python_version = "PythonVersion",
    };
};
