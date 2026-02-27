/// The resource policy that allows Incident Manager to perform actions on
/// resources on your
/// behalf.
pub const ResourcePolicy = struct {
    /// The JSON blob that describes the policy.
    policy_document: []const u8,

    /// The ID of the resource policy.
    policy_id: []const u8,

    /// The Amazon Web Services Region that policy allows resources to be used in.
    ram_resource_share_region: []const u8,

    pub const json_field_names = .{
        .policy_document = "policyDocument",
        .policy_id = "policyId",
        .ram_resource_share_region = "ramResourceShareRegion",
    };
};
