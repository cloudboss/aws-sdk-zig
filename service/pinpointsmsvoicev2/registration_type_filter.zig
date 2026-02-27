const RegistrationTypeFilterName = @import("registration_type_filter_name.zig").RegistrationTypeFilterName;

/// The filter definition for filtering registration types that meets a
/// specified criteria.
pub const RegistrationTypeFilter = struct {
    /// The name of the attribute to filter on.
    name: RegistrationTypeFilterName,

    /// An array of values to filter on.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
