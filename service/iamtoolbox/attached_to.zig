/// An entity that a policy is attached to, identified by its ARN.
pub const AttachedTo = struct {
    /// The ARN of the entity that the policy is attached to. The ARN format depends
    /// on the policy type:
    ///
    /// * For identity, session, and permissions boundary policies, this is the
    ///   principal ARN (for example, an IAM role or user ARN).
    /// * For resource-based policies, this is the resource ARN.
    /// * For organization control policies (SCPs and RCPs), this is the AWS
    ///   Organizations ARN of the account, organizational unit, or root.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
