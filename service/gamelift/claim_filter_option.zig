const FilterInstanceStatus = @import("filter_instance_status.zig").FilterInstanceStatus;

/// Filters which game servers may be claimed when calling `ClaimGameServer`.
pub const ClaimFilterOption = struct {
    /// List of instance statuses that game servers may be claimed on. If provided,
    /// the list must contain the
    /// `ACTIVE` status.
    instance_statuses: ?[]const FilterInstanceStatus = null,

    pub const json_field_names = .{
        .instance_statuses = "InstanceStatuses",
    };
};
