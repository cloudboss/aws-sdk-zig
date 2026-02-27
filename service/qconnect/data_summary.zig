const DataDetails = @import("data_details.zig").DataDetails;
const DataReference = @import("data_reference.zig").DataReference;

/// Summary of the data.
pub const DataSummary = struct {
    /// Details about the data.
    details: DataDetails,

    /// Reference information about the content.
    reference: DataReference,

    pub const json_field_names = .{
        .details = "details",
        .reference = "reference",
    };
};
