const PatchFilter = @import("patch_filter.zig").PatchFilter;

/// A set of patch filters, typically used for approval rules.
pub const PatchFilterGroup = struct {
    /// The set of patch filters that make up the group.
    patch_filters: []const PatchFilter,

    pub const json_field_names = .{
        .patch_filters = "PatchFilters",
    };
};
