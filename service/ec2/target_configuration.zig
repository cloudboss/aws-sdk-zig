/// Information about the Convertible Reserved Instance offering.
pub const TargetConfiguration = struct {
    /// The number of instances the Convertible Reserved Instance offering can be
    /// applied to. This
    /// parameter is reserved and cannot be specified in a request
    instance_count: ?i32 = null,

    /// The ID of the Convertible Reserved Instance offering.
    offering_id: ?[]const u8 = null,
};
