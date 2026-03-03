/// Information about additional load balancer attributes.
pub const AdditionalAttribute = struct {
    /// The name of the attribute.
    ///
    /// The following attribute is supported.
    ///
    /// * `elb.http.desyncmitigationmode` - Determines how the load balancer handles
    ///   requests that
    /// might pose a security risk to your application. The possible values are
    /// `monitor`,
    /// `defensive`, and `strictest`. The default is `defensive`.
    key: ?[]const u8 = null,

    /// This value of the attribute.
    value: ?[]const u8 = null,
};
