/// A structure that contains details about a static policy. It includes the
/// description and policy statement.
///
/// This data type is used within a
/// [PolicyDefinition](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_PolicyDefinition.html) structure as part of a request parameter for the [CreatePolicy](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_CreatePolicy.html) operation.
pub const StaticPolicyDefinitionItem = struct {
    /// A description of the static policy.
    description: ?[]const u8,

    pub const json_field_names = .{
        .description = "description",
    };
};
