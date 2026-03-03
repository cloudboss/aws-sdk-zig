/// Contains information about an exported environment variable.
///
/// Exported environment variables are used in conjunction with CodePipeline to
/// export
/// environment variables from the current build stage to subsequent stages in
/// the pipeline.
/// For more information, see [Working with
/// variables](https://docs.aws.amazon.com/codepipeline/latest/userguide/actions-variables.html) in the *CodePipeline User Guide*.
///
/// During a build, the value of a variable is available starting with the
/// `install` phase. It can be updated between the start of the
/// `install` phase and the end of the `post_build` phase.
/// After the `post_build` phase ends, the value of exported variables cannot
/// change.
pub const ExportedEnvironmentVariable = struct {
    /// The name of the exported environment variable.
    name: ?[]const u8 = null,

    /// The value assigned to the exported environment variable.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
