const PreferredResourceName = @import("preferred_resource_name.zig").PreferredResourceName;

/// Describes the effective preferred resources that Compute Optimizer considers
/// as rightsizing recommendation candidates.
///
/// Compute Optimizer only supports Amazon EC2 instance types.
pub const EffectivePreferredResource = struct {
    /// The expanded version of your preferred resource's include list.
    effective_include_list: ?[]const []const u8,

    /// The list of preferred resources values that you want excluded from
    /// rightsizing recommendation candidates.
    exclude_list: ?[]const []const u8,

    /// The list of preferred resource values that you want considered as
    /// rightsizing recommendation candidates.
    include_list: ?[]const []const u8,

    /// The name of the preferred resource list.
    name: ?PreferredResourceName,

    pub const json_field_names = .{
        .effective_include_list = "effectiveIncludeList",
        .exclude_list = "excludeList",
        .include_list = "includeList",
        .name = "name",
    };
};
