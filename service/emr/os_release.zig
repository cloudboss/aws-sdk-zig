/// The Amazon Linux release specified for a cluster in the RunJobFlow request.
pub const OSRelease = struct {
    /// The Amazon Linux release specified for a cluster in the RunJobFlow request.
    /// The format
    /// is as shown in [
    /// *Amazon Linux 2 Release Notes*
    /// ](https://docs.aws.amazon.com/AL2/latest/relnotes/relnotes-20220218.html).
    /// For example,
    /// 2.0.20220218.1.
    label: ?[]const u8 = null,

    pub const json_field_names = .{
        .label = "Label",
    };
};
