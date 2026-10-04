const RackSpecificationDetails = @import("rack_specification_details.zig").RackSpecificationDetails;
const QuoteSpecificationType = @import("quote_specification_type.zig").QuoteSpecificationType;
const ServerSpecificationDetails = @import("server_specification_details.zig").ServerSpecificationDetails;

/// A physical specification for a quote option. Describes the rack or server
/// configuration
/// that would be deployed.
pub const QuoteSpecification = struct {
    /// The existing rack specification details, if the specification type is
    /// `UPDATED_RACK` or `EXISTING_RACK`.
    existing_rack_specification_details: ?RackSpecificationDetails = null,

    /// The final rack specification details after the quote is fulfilled.
    final_rack_specification_details: ?RackSpecificationDetails = null,

    /// The type of specification. Valid values are `NEW_RACK`,
    /// `UPDATED_RACK`, `EXISTING_RACK`, and `SERVER`.
    quote_specification_type: ?QuoteSpecificationType = null,

    /// The server specification details, if the specification type is
    /// `SERVER`.
    server_specification_details: ?ServerSpecificationDetails = null,

    pub const json_field_names = .{
        .existing_rack_specification_details = "ExistingRackSpecificationDetails",
        .final_rack_specification_details = "FinalRackSpecificationDetails",
        .quote_specification_type = "QuoteSpecificationType",
        .server_specification_details = "ServerSpecificationDetails",
    };
};
