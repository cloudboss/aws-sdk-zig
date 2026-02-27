/// A structure that contains details about a static policy. It includes the
/// description and policy body.
///
/// This data type is used within a
/// [PolicyDefinition](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_PolicyDefinition.html) structure as part of a request parameter for the [CreatePolicy](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_CreatePolicy.html) operation.
pub const StaticPolicyDefinitionDetail = struct {
    /// A description of the static policy.
    description: ?[]const u8,

    /// The content of the static policy written in the Cedar policy language.
    statement: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .statement = "statement",
    };
};
