const ApplicableToType = @import("applicable_to_type.zig").ApplicableToType;

/// The scoping configuration that determines which principals an approval
/// policy applies to.
pub const ApplicableTo = struct {
    /// The list of group ARNs that the policy applies to. Required when type is
    /// GROUP.
    group_arns: ?[]const []const u8 = null,

    /// The type of scoping that determines which principals the approval policy
    /// applies to. Valid values
    /// are defined as follows:
    ///
    /// * `GROUP`: The policy applies only to principals in the groups specified by
    /// `GroupArns`. When you use `GROUP`, you must also provide a value for
    /// `GroupArns`.
    type: ApplicableToType,

    pub const json_field_names = .{
        .group_arns = "GroupArns",
        .type = "Type",
    };
};
