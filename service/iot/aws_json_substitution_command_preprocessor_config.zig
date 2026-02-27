const OutputFormat = @import("output_format.zig").OutputFormat;

/// Configures the command to treat the `payloadTemplate` as a JSON document for
/// preprocessing.
/// This preprocessor substitutes placeholders with parameter values to generate
/// the command execution request payload.
pub const AwsJsonSubstitutionCommandPreprocessorConfig = struct {
    /// Converts the command preprocessor result to the format defined by this
    /// parameter, before sending it to the device.
    output_format: OutputFormat,

    pub const json_field_names = .{
        .output_format = "outputFormat",
    };
};
