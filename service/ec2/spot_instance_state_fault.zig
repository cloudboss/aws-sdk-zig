/// Describes a Spot Instance state change.
pub const SpotInstanceStateFault = struct {
    /// The reason code for the Spot Instance state change.
    code: ?[]const u8,

    /// The message for the Spot Instance state change.
    message: ?[]const u8,
};
