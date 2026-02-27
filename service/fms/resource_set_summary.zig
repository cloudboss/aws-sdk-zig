const ResourceSetStatus = @import("resource_set_status.zig").ResourceSetStatus;

/// Summarizes the resource sets used in a policy.
pub const ResourceSetSummary = struct {
    /// A description of the resource set.
    description: ?[]const u8,

    /// A unique identifier for the resource set. This ID is returned in the
    /// responses to create and list commands. You provide it to operations like
    /// update and delete.
    id: ?[]const u8,

    /// The last time that the resource set was changed.
    last_update_time: ?i64,

    /// The descriptive name of the resource set. You can't change the name of a
    /// resource set after you create it.
    name: ?[]const u8,

    /// Indicates whether the resource set is in or out of an admin's Region scope.
    ///
    /// * `ACTIVE` - The administrator can manage and delete the resource set.
    ///
    /// * `OUT_OF_ADMIN_SCOPE` - The administrator can view the resource set, but
    ///   they can't edit or delete the resource set. Existing protections stay in
    ///   place. Any new resource that come into scope of the resource set won't be
    ///   protected.
    resource_set_status: ?ResourceSetStatus,

    pub const json_field_names = .{
        .description = "Description",
        .id = "Id",
        .last_update_time = "LastUpdateTime",
        .name = "Name",
        .resource_set_status = "ResourceSetStatus",
    };
};
