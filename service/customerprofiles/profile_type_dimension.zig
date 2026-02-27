const ProfileTypeDimensionType = @import("profile_type_dimension_type.zig").ProfileTypeDimensionType;
const ProfileType = @import("profile_type.zig").ProfileType;

/// Object to hold the dimension of a profile type field to segment on.
pub const ProfileTypeDimension = struct {
    /// The action to segment on.
    dimension_type: ProfileTypeDimensionType,

    /// The values to apply the DimensionType on.
    values: []const ProfileType,

    pub const json_field_names = .{
        .dimension_type = "DimensionType",
        .values = "Values",
    };
};
