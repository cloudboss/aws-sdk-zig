const AWSDomainInformation = @import("aws_domain_information.zig").AWSDomainInformation;

/// Container for information about an OpenSearch Service domain.
pub const DomainInformationContainer = struct {
    /// Information about an Amazon OpenSearch Service domain.
    aws_domain_information: ?AWSDomainInformation = null,

    pub const json_field_names = .{
        .aws_domain_information = "AWSDomainInformation",
    };
};
