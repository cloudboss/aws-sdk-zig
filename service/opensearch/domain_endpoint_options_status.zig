const DomainEndpointOptions = @import("domain_endpoint_options.zig").DomainEndpointOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The configured endpoint options for a domain and their current status.
pub const DomainEndpointOptionsStatus = struct {
    /// Options to configure the endpoint for a domain.
    options: DomainEndpointOptions,

    /// The status of the endpoint options for a domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
