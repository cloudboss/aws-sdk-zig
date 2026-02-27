/// Specifies code that runs when a job is run.
pub const JobCommand = struct {
    /// The name of the job command. For an Apache Spark ETL job, this must be
    /// `glueetl`. For a Python shell job, it must be `pythonshell`.
    /// For an Apache Spark streaming ETL job, this must be `gluestreaming`. For a
    /// Ray job,
    /// this must be `glueray`.
    name: ?[]const u8,

    /// The Python version being used to run a Python shell job. Allowed values are
    /// 2 or 3.
    python_version: ?[]const u8,

    /// In Ray jobs, Runtime is used to specify the versions of Ray, Python and
    /// additional
    /// libraries available in your environment. This field is not used in other job
    /// types. For
    /// supported runtime environment values, see [Supported Ray runtime
    /// environments](https://docs.aws.amazon.com/glue/latest/dg/ray-jobs-section.html)
    /// in the Glue Developer Guide.
    runtime: ?[]const u8,

    /// Specifies the Amazon Simple Storage Service (Amazon S3) path to a script
    /// that runs a
    /// job.
    script_location: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .python_version = "PythonVersion",
        .runtime = "Runtime",
        .script_location = "ScriptLocation",
    };
};
