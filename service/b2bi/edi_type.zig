const X12Details = @import("x12_details.zig").X12Details;

/// Specifies the details for the EDI standard that is being used for the
/// transformer. Currently, only X12 is supported. X12 is a set of standards and
/// corresponding messages that define specific business documents.
pub const EdiType = union(enum) {
    /// Returns the details for the EDI standard that is being used for the
    /// transformer. Currently, only X12 is supported. X12 is a set of standards and
    /// corresponding messages that define specific business documents.
    x_12_details: ?X12Details,

    pub const json_field_names = .{
        .x_12_details = "x12Details",
    };
};
