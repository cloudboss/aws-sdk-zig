pub const CreateEndpointResult = struct {
    /// The Amazon Resource Name (ARN) of the endpoint.
    endpoint_arn: ?[]const u8,

    pub const json_field_names = .{
        .endpoint_arn = "EndpointArn",
    };
};
