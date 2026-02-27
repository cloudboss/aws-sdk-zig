const RegistrationAssociationFilterName = @import("registration_association_filter_name.zig").RegistrationAssociationFilterName;

/// The filter definition for filtering registrations that meets a specified
/// criteria.
pub const RegistrationAssociationFilter = struct {
    /// The name of the attribute to filter on.
    name: RegistrationAssociationFilterName,

    /// An array of values to filter for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
