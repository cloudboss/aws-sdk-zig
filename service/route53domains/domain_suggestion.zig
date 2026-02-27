/// Information about one suggested domain name.
pub const DomainSuggestion = struct {
    /// Whether the domain name is available for registering.
    ///
    /// You can register only the domains that are designated as
    /// `AVAILABLE`.
    ///
    /// Valid values:
    ///
    /// **AVAILABLE**
    ///
    /// The domain name is available.
    ///
    /// **AVAILABLE_RESERVED**
    ///
    /// The domain name is reserved under specific conditions.
    ///
    /// **AVAILABLE_PREORDER**
    ///
    /// The domain name is available and can be preordered.
    ///
    /// **DONT_KNOW**
    ///
    /// The TLD registry didn't reply with a definitive answer about whether the
    /// domain name is available. Route 53 can return this response for a variety of
    /// reasons, for example, the registry is performing maintenance. Try again
    /// later.
    ///
    /// **PENDING**
    ///
    /// The TLD registry didn't return a response in the expected amount of time.
    /// When the response is delayed, it usually takes just a few extra seconds. You
    /// can resubmit the request immediately.
    ///
    /// **RESERVED**
    ///
    /// The domain name has been reserved for another person or
    /// organization.
    ///
    /// **UNAVAILABLE**
    ///
    /// The domain name is not available.
    ///
    /// **UNAVAILABLE_PREMIUM**
    ///
    /// The domain name is not available.
    ///
    /// **UNAVAILABLE_RESTRICTED**
    ///
    /// The domain name is forbidden.
    availability: ?[]const u8,

    /// A suggested domain name.
    domain_name: ?[]const u8,

    pub const json_field_names = .{
        .availability = "Availability",
        .domain_name = "DomainName",
    };
};
