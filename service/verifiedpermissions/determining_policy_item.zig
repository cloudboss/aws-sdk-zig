/// Contains information about one of the policies that determined an
/// authorization decision.
///
/// This data type is used as an element in a response parameter for the
/// [IsAuthorized](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorized.html), [BatchIsAuthorized](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_BatchIsAuthorized.html), and [IsAuthorizedWithToken](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorizedWithToken.html) operations.
///
/// Example: `"determiningPolicies":[{"policyId":"SPEXAMPLEabcdefg111111"}]`
pub const DeterminingPolicyItem = struct {
    /// The Id of a policy that determined to an authorization decision.
    ///
    /// Example: `"policyId":"SPEXAMPLEabcdefg111111"`
    policy_id: []const u8,

    pub const json_field_names = .{
        .policy_id = "policyId",
    };
};
