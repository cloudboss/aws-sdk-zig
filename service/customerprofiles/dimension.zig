const aws = @import("aws");

const CalculatedAttributeDimension = @import("calculated_attribute_dimension.zig").CalculatedAttributeDimension;
const ProfileAttributes = @import("profile_attributes.zig").ProfileAttributes;

/// Object that holds what profile and calculated attributes to segment on.
pub const Dimension = union(enum) {
    /// Object that holds the calculated attributes to segment on.
    calculated_attributes: ?[]const aws.map.MapEntry(CalculatedAttributeDimension),
    /// Object that holds the profile attributes to segment on.
    profile_attributes: ?ProfileAttributes,

    pub const json_field_names = .{
        .calculated_attributes = "CalculatedAttributes",
        .profile_attributes = "ProfileAttributes",
    };
};
