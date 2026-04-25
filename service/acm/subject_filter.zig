const CommonNameFilter = @import("common_name_filter.zig").CommonNameFilter;

/// Filters certificates by subject attributes.
pub const SubjectFilter = union(enum) {
    /// Filter by common name in the subject.
    common_name: ?CommonNameFilter,

    pub const json_field_names = .{
        .common_name = "CommonName",
    };
};
