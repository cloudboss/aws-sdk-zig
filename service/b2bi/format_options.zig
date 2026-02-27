const X12Details = @import("x12_details.zig").X12Details;

/// A structure that contains the X12 transaction set and version.
pub const FormatOptions = union(enum) {
    x_12: ?X12Details,

    pub const json_field_names = .{
        .x_12 = "x12",
    };
};
