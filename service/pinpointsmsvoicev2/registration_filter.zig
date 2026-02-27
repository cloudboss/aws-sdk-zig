const RegistrationFilterName = @import("registration_filter_name.zig").RegistrationFilterName;

/// The filter definition for filtering registrations that meets a specified
/// criteria.
pub const RegistrationFilter = struct {
    /// The name of the attribute to filter on.
    name: RegistrationFilterName,

    /// An array of values to filter on.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
