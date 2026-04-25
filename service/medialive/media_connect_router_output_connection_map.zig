/// Map of MediaLive pipeline IDs to the ARNs of the MediaConnect Router Inputs
/// to which this Output is connected.
pub const MediaConnectRouterOutputConnectionMap = struct {
    /// The ARN of the MediaConnect Router Input connected to pipeline 0.
    pipeline_0: ?[]const u8 = null,

    /// The ARN of the MediaConnect Router Input connected to pipeline 1.
    pipeline_1: ?[]const u8 = null,

    pub const json_field_names = .{
        .pipeline_0 = "Pipeline0",
        .pipeline_1 = "Pipeline1",
    };
};
