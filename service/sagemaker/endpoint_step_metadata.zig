/// Metadata for an endpoint step.
pub const EndpointStepMetadata = struct {
    /// The Amazon Resource Name (ARN) of the endpoint in the step.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
