/// Contains details about a policy that was deleted, including the number of
/// services that were affected.
pub const PolicyDeletedMetadata = struct {
    /// The number of services that were using the policy when it was deleted.
    affected_service_count: ?i32 = null,

    pub const json_field_names = .{
        .affected_service_count = "affectedServiceCount",
    };
};
