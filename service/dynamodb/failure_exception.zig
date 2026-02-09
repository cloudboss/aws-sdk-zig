/// Represents a failure a contributor insights operation.
pub const FailureException = struct {
    /// Description of the failure.
    exception_description: ?[]const u8,

    /// Exception name.
    exception_name: ?[]const u8,
};
