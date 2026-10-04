/// Contains information about the role template that a role was created from.
pub const SourceRoleTemplate = struct {
    /// The Amazon Resource Name (ARN) of the role template that the role was
    /// created
    /// from.
    template_arn: []const u8,

    /// The minor version of the role template that was used to create the role.
    template_minor_version: i32,
};
