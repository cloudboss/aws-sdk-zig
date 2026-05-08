/// Connection details for a single pipeline of a MediaConnect Router output.
pub const MediaConnectRouterOutputConnection = struct {
    /// The ARN of the MediaConnect Router Input connected to this pipeline.
    router_input_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .router_input_arn = "RouterInputArn",
    };
};
