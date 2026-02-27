const DateRange = @import("date_range.zig").DateRange;

/// This specifies criteria to assign
/// a set of resources, such as resource types or backup vaults.
pub const RecoveryPointSelection = struct {
    date_range: ?DateRange,

    /// These are the resources included in the resource selection
    /// (including type of resources and vaults).
    resource_identifiers: ?[]const []const u8,

    /// These are the names of the vaults in which the selected
    /// recovery points are contained.
    vault_names: ?[]const []const u8,

    pub const json_field_names = .{
        .date_range = "DateRange",
        .resource_identifiers = "ResourceIdentifiers",
        .vault_names = "VaultNames",
    };
};
