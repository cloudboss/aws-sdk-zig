/// Contains details about a policy for which organization sharing was revoked,
/// including the number of services that were affected.
pub const PolicySharingRevokedMetadata = struct {
    /// The number of services that were using the policy when sharing was revoked.
    affected_service_count: ?i32 = null,

    pub const json_field_names = .{
        .affected_service_count = "affectedServiceCount",
    };
};
