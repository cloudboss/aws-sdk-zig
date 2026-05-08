const RequestedTermConfiguration = @import("requested_term_configuration.zig").RequestedTermConfiguration;

/// Defines what is being accepted as part of the agreement creation or update
/// request, and it includes their configurations.
pub const RequestedTerm = struct {
    /// Additional configuration for the requested terms. This configuration is
    /// applicable only to the terms that accept a customer-provided configuration,
    /// such as `ConfigurableUpfrontPricingTerm`.
    configuration: ?RequestedTermConfiguration = null,

    /// The unique identifier of the term in the agreement proposal.
    id: []const u8,

    pub const json_field_names = .{
        .configuration = "configuration",
        .id = "id",
    };
};
