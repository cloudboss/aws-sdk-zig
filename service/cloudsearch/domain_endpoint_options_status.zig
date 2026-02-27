const DomainEndpointOptions = @import("domain_endpoint_options.zig").DomainEndpointOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The configuration and status of the domain's endpoint options.
pub const DomainEndpointOptionsStatus = struct {
    /// The domain endpoint options configured for the domain.
    options: DomainEndpointOptions,

    /// The status of the configured domain endpoint options.
    status: OptionStatus,
};
