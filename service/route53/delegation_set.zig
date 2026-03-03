/// A complex type that lists the name servers in a delegation set, as well as
/// the
/// `CallerReference` and the `ID` for the delegation set.
pub const DelegationSet = struct {
    /// The value that you specified for `CallerReference` when you created the
    /// reusable delegation set.
    caller_reference: ?[]const u8 = null,

    /// The ID that Amazon Route 53 assigns to a reusable delegation set.
    id: ?[]const u8 = null,

    /// A complex type that contains a list of the authoritative name servers for a
    /// hosted
    /// zone or for a reusable delegation set.
    name_servers: []const []const u8,
};
