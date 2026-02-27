const X12Details = @import("x12_details.zig").X12Details;

/// Contains a structure describing the X12 details for the conversion target.
pub const ConversionTargetFormatDetails = union(enum) {
    x_12: ?X12Details,

    pub const json_field_names = .{
        .x_12 = "x12",
    };
};
