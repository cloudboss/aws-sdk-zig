const VerifiedDestinationNumberFilterName = @import("verified_destination_number_filter_name.zig").VerifiedDestinationNumberFilterName;

/// The filter definition for filtering verified destination phone numbers that
/// meets a specified criteria.
pub const VerifiedDestinationNumberFilter = struct {
    /// The name of the attribute to filter on.
    name: VerifiedDestinationNumberFilterName,

    /// An array of values to filter on.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
