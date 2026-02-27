const LambdaConfiguration = @import("lambda_configuration.zig").LambdaConfiguration;

/// A processor's metadata.
pub const ProcessorConfiguration = struct {
    /// Indicates that the processor is of type Lambda.
    lambda: LambdaConfiguration,

    pub const json_field_names = .{
        .lambda = "Lambda",
    };
};
