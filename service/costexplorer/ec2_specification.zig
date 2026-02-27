const OfferingClass = @import("offering_class.zig").OfferingClass;

/// The Amazon EC2 hardware specifications that you want Amazon Web Services to
/// provide
/// recommendations for.
pub const EC2Specification = struct {
    /// Indicates whether you want a recommendation for standard or convertible
    /// reservations.
    offering_class: ?OfferingClass,

    pub const json_field_names = .{
        .offering_class = "OfferingClass",
    };
};
