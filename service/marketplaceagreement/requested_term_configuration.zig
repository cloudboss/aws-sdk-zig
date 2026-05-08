const ConfigurableUpfrontPricingTermConfiguration = @import("configurable_upfront_pricing_term_configuration.zig").ConfigurableUpfrontPricingTermConfiguration;
const RenewalTermConfiguration = @import("renewal_term_configuration.zig").RenewalTermConfiguration;
const VariablePaymentTermConfiguration = @import("variable_payment_term_configuration.zig").VariablePaymentTermConfiguration;

/// A tagged union that represents the term configuration provided by the
/// acceptor. Only one configuration is accepted per term.
pub const RequestedTermConfiguration = union(enum) {
    configurable_upfront_pricing_term_configuration: ?ConfigurableUpfrontPricingTermConfiguration,
    renewal_term_configuration: ?RenewalTermConfiguration,
    variable_payment_term_configuration: ?VariablePaymentTermConfiguration,

    pub const json_field_names = .{
        .configurable_upfront_pricing_term_configuration = "configurableUpfrontPricingTermConfiguration",
        .renewal_term_configuration = "renewalTermConfiguration",
        .variable_payment_term_configuration = "variablePaymentTermConfiguration",
    };
};
