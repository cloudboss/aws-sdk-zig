/// Information about the identifiers of a package group.
pub const PackageGroupReference = struct {
    /// The ARN of the package group.
    arn: ?[]const u8 = null,

    /// The pattern of the package group. The pattern determines which packages are
    /// associated with the package group, and is
    /// also the identifier of the package group.
    pattern: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .pattern = "pattern",
    };
};
