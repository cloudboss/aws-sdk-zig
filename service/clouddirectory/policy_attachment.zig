/// Contains the `PolicyType`, `PolicyId`, and the `ObjectIdentifier` to which
/// it is
/// attached. For more
/// information, see
/// [Policies](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/key_concepts_directory.html#key_concepts_policies).
pub const PolicyAttachment = struct {
    /// The `ObjectIdentifier` that is associated with
    /// `PolicyAttachment`.
    object_identifier: ?[]const u8,

    /// The ID of `PolicyAttachment`.
    policy_id: ?[]const u8,

    /// The type of policy that can be associated with `PolicyAttachment`.
    policy_type: ?[]const u8,

    pub const json_field_names = .{
        .object_identifier = "ObjectIdentifier",
        .policy_id = "PolicyId",
        .policy_type = "PolicyType",
    };
};
