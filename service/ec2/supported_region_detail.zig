/// Describes a supported Region.
pub const SupportedRegionDetail = struct {
    /// The Region code.
    region: ?[]const u8 = null,

    /// The service state. The possible values are `Pending`, `Available`,
    /// `Deleting`, `Deleted`, `Failed`, and `Closed`.
    service_state: ?[]const u8 = null,
};
