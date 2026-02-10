/// Details about the target configuration.
pub const TargetConfigurationRequest = struct {
    /// The number of instances the Convertible Reserved Instance offering can be
    /// applied to. This
    /// parameter is reserved and cannot be specified in a request
    instance_count: ?i32,

    /// The Convertible Reserved Instance offering ID.
    offering_id: []const u8,
};
