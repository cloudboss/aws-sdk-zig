const PhoneNumberFilterName = @import("phone_number_filter_name.zig").PhoneNumberFilterName;

/// The information for a phone number that meets a specified criteria.
pub const PhoneNumberFilter = struct {
    /// The name of the attribute to filter on.
    name: PhoneNumberFilterName,

    /// An array values to filter for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
