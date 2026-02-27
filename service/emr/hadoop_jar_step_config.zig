const KeyValue = @import("key_value.zig").KeyValue;

/// A job flow step consisting of a JAR file whose main function will be
/// executed. The main
/// function submits a job for Hadoop to execute and waits for the job to finish
/// or
/// fail.
pub const HadoopJarStepConfig = struct {
    /// A list of command line arguments passed to the JAR file's main function when
    /// executed.
    args: ?[]const []const u8,

    /// A path to a JAR file run during the step.
    jar: []const u8,

    /// The name of the main class in the specified Java file. If not specified, the
    /// JAR file
    /// should specify a Main-Class in its manifest file.
    main_class: ?[]const u8,

    /// A list of Java properties that are set when the step runs. You can use these
    /// properties
    /// to pass key-value pairs to your main function.
    properties: ?[]const KeyValue,

    pub const json_field_names = .{
        .args = "Args",
        .jar = "Jar",
        .main_class = "MainClass",
        .properties = "Properties",
    };
};
