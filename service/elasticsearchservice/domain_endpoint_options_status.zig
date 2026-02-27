const DomainEndpointOptions = @import("domain_endpoint_options.zig").DomainEndpointOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The configured endpoint options for the domain and their current status.
pub const DomainEndpointOptionsStatus = struct {
    /// Options to configure endpoint for the Elasticsearch domain.
    options: DomainEndpointOptions,

    /// The status of the endpoint options for the Elasticsearch domain. See
    /// `OptionStatus` for the status information that's included.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
