/// Used in CreateNodeRequest, CreateNodeRegistrationScriptRequest,
/// DescribeNodeResult, DescribeNodeSummary, UpdateNodeRequest.
pub const NodeRole = enum {
    backup,
    active,

    pub const json_field_names = .{
        .backup = "BACKUP",
        .active = "ACTIVE",
    };
};
