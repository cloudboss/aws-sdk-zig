/// Metadata for an endpoint configuration step.
pub const EndpointConfigStepMetadata = struct {
    /// The Amazon Resource Name (ARN) of the endpoint configuration used in the
    /// step.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
