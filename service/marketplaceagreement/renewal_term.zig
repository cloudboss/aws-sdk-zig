const RenewalTermConfiguration = @import("renewal_term_configuration.zig").RenewalTermConfiguration;

/// Defines that on graceful expiration of the agreement (when the agreement
/// ends on its pre-defined end date), a new agreement will be created using the
/// accepted terms on the existing agreement. In other words, the agreement will
/// be renewed. The presence of `RenewalTerm` in the offer document means that
/// auto-renewal is allowed. Buyers will have the option to accept or decline
/// auto-renewal at the offer acceptance/agreement creation. Buyers can also
/// change this flag from `True` to `False` or `False` to `True` at anytime
/// during the agreement's lifecycle.
pub const RenewalTerm = struct {
    /// Additional parameters specified by the acceptor while accepting the term.
    configuration: ?RenewalTermConfiguration = null,

    /// Category of the term being updated.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .@"type" = "type",
    };
};
