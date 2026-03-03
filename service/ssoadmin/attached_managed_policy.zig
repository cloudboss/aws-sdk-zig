/// A structure that stores a list of managed policy ARNs that describe the
/// associated Amazon Web Services managed policy.
pub const AttachedManagedPolicy = struct {
    /// The ARN of the Amazon Web Services managed policy. For more information
    /// about ARNs, see [Amazon Resource Names (ARNs) and Amazon Web Services
    /// Service Namespaces](/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference*.
    arn: ?[]const u8 = null,

    /// The name of the Amazon Web Services managed policy.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
