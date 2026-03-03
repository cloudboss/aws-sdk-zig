const aws = @import("aws");

/// A cluster step consisting of a JAR file whose main function will be
/// executed. The main
/// function submits a job for Hadoop to execute and waits for the job to finish
/// or
/// fail.
pub const HadoopStepConfig = struct {
    /// The list of command line arguments to pass to the JAR file's main function
    /// for
    /// execution.
    args: ?[]const []const u8 = null,

    /// The path to the JAR file that runs during the step.
    jar: ?[]const u8 = null,

    /// The name of the main class in the specified Java file. If not specified, the
    /// JAR file
    /// should specify a main class in its manifest file.
    main_class: ?[]const u8 = null,

    /// The list of Java properties that are set when the step runs. You can use
    /// these
    /// properties to pass key-value pairs to your main function.
    properties: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .args = "Args",
        .jar = "Jar",
        .main_class = "MainClass",
        .properties = "Properties",
    };
};
