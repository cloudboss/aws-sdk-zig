/// A summary of the domain that a common control or an objective belongs to.
pub const AssociatedDomainSummary = struct {
    /// The Amazon Resource Name (ARN) of the related domain.
    arn: ?[]const u8 = null,

    /// The name of the related domain.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
