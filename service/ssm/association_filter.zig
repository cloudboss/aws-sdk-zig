const AssociationFilterKey = @import("association_filter_key.zig").AssociationFilterKey;

/// Describes a filter.
pub const AssociationFilter = struct {
    /// The name of the filter.
    ///
    /// **Note:**
    ///
    /// `InstanceId` has been deprecated.
    key: AssociationFilterKey,

    /// The filter value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
