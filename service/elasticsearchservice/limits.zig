const AdditionalLimit = @import("additional_limit.zig").AdditionalLimit;
const InstanceLimits = @import("instance_limits.zig").InstanceLimits;
const StorageType = @import("storage_type.zig").StorageType;

/// Limits for given InstanceType and for each of it's role.
///
/// Limits contains following
/// `
/// StorageTypes,
/// `
/// `
/// InstanceLimits
/// `
/// and
/// `
/// AdditionalLimits
/// `
pub const Limits = struct {
    /// List of additional limits that are specific to a given InstanceType and for
    /// each of it's
    /// `
    /// InstanceRole
    /// `
    /// .
    additional_limits: ?[]const AdditionalLimit,

    instance_limits: ?InstanceLimits,

    /// StorageType represents the list of storage related types and attributes
    /// that are available for given InstanceType.
    storage_types: ?[]const StorageType,

    pub const json_field_names = .{
        .additional_limits = "AdditionalLimits",
        .instance_limits = "InstanceLimits",
        .storage_types = "StorageTypes",
    };
};
