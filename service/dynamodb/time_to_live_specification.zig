/// Represents the settings used to enable or disable Time to Live (TTL) for the
/// specified
/// table.
pub const TimeToLiveSpecification = struct {
    /// The name of the TTL attribute used to store the expiration time for items in
    /// the
    /// table.
    attribute_name: []const u8,

    /// Indicates whether TTL is to be enabled (true) or disabled (false) on the
    /// table.
    enabled: bool,
};
