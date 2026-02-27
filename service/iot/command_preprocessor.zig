const AwsJsonSubstitutionCommandPreprocessorConfig = @import("aws_json_substitution_command_preprocessor_config.zig").AwsJsonSubstitutionCommandPreprocessorConfig;

/// Configuration that determines how the `payloadTemplate` is processed by the
/// service to generate the final payload sent to
/// devices at `StartCommandExecution` API invocation.
pub const CommandPreprocessor = struct {
    /// Configuration for the JSON substitution preprocessor.
    aws_json_substitution: ?AwsJsonSubstitutionCommandPreprocessorConfig,

    pub const json_field_names = .{
        .aws_json_substitution = "awsJsonSubstitution",
    };
};
