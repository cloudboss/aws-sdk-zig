/// The domain resource that's being used as a filter.
pub const DomainResourceFilter = struct {
    /// The Amazon Resource Name (ARN) of the domain.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
