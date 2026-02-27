const X12Details = @import("x12_details.zig").X12Details;

/// A data structure that contains the information to use when generating a
/// mapping template.
pub const TemplateDetails = union(enum) {
    x_12: ?X12Details,

    pub const json_field_names = .{
        .x_12 = "x12",
    };
};
