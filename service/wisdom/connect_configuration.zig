/// The configuration information of the Amazon Connect data source.
pub const ConnectConfiguration = struct {
    /// The identifier of the Amazon Connect instance. You can find the instanceId
    /// in the ARN of the instance.
    instance_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_id = "instanceId",
    };
};
