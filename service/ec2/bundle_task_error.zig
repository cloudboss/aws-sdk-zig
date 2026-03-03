/// Describes an error for BundleInstance.
pub const BundleTaskError = struct {
    /// The error code.
    code: ?[]const u8 = null,

    /// The error message.
    message: ?[]const u8 = null,
};
