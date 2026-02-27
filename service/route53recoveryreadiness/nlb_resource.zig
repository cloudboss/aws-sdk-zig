/// The Network Load Balancer resource that a DNS target resource points to.
pub const NLBResource = struct {
    /// The Network Load Balancer resource Amazon Resource Name (ARN).
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
