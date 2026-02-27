const PolicyTypeStatus = @import("policy_type_status.zig").PolicyTypeStatus;
const PolicyType = @import("policy_type.zig").PolicyType;

/// Contains information about a policy type and its status in the associated
/// root.
pub const PolicyTypeSummary = struct {
    /// The status of the policy type as it relates to the associated root. To
    /// attach a policy
    /// of the specified type to a root or to an OU or account in that root, it must
    /// be
    /// available in the organization and enabled for that root.
    status: ?PolicyTypeStatus,

    /// The name of the policy type.
    type: ?PolicyType,

    pub const json_field_names = .{
        .status = "Status",
        .type = "Type",
    };
};
