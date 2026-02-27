/// The type of action that occurred for the resource and produced the policy
/// finding:
pub const FindingActionType = enum {
    aws_api_call,

    pub const json_field_names = .{
        .aws_api_call = "AWS_API_CALL",
    };
};
