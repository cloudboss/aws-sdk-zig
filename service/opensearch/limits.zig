const AdditionalLimit = @import("additional_limit.zig").AdditionalLimit;
const InstanceLimits = @import("instance_limits.zig").InstanceLimits;
const StorageType = @import("storage_type.zig").StorageType;

/// Limits for a given instance type and for each of its roles.
pub const Limits = struct {
    /// List of additional limits that are specific to a given instance type for
    /// each of its
    /// instance roles.
    additional_limits: ?[]const AdditionalLimit = null,

    /// The limits for a given instance type.
    instance_limits: ?InstanceLimits = null,

    /// Storage-related attributes that are available for a given instance type.
    storage_types: ?[]const StorageType = null,

    pub const json_field_names = .{
        .additional_limits = "AdditionalLimits",
        .instance_limits = "InstanceLimits",
        .storage_types = "StorageTypes",
    };
};
