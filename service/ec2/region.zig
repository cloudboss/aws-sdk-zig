/// Describes a Region.
pub const Region = struct {
    /// The Region service endpoint.
    endpoint: ?[]const u8 = null,

    /// The Region opt-in status. The possible values are `opt-in-not-required`,
    /// `opted-in`, and
    /// `not-opted-in`.
    opt_in_status: ?[]const u8 = null,

    /// The name of the Region.
    region_name: ?[]const u8 = null,
};
