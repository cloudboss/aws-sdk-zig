const RegistrationVersionFilterName = @import("registration_version_filter_name.zig").RegistrationVersionFilterName;

/// The filter definition for filtering registration versions that meets a
/// specified criteria.
pub const RegistrationVersionFilter = struct {
    /// The name of the attribute to filter on.
    name: RegistrationVersionFilterName,

    /// An array of values to filter on.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
