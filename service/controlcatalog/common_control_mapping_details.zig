/// A structure that contains details about a common control mapping. In
/// particular, it returns the Amazon Resource Name (ARN) of the common control.
pub const CommonControlMappingDetails = struct {
    /// The Amazon Resource Name (ARN) that identifies the common control in the
    /// mapping.
    common_control_arn: []const u8,

    pub const json_field_names = .{
        .common_control_arn = "CommonControlArn",
    };
};
