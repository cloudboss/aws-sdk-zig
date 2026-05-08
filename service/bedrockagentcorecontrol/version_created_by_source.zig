/// The source that created a configuration bundle version.
pub const VersionCreatedBySource = struct {
    /// The Amazon Resource Name (ARN) of the source, if applicable (for example, a
    /// user ARN or optimization job ARN).
    arn: ?[]const u8 = null,

    /// The name of the source (for example, `user`, `optimization-job`, or
    /// `system`).
    name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
    };
};
