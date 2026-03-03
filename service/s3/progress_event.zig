const Progress = @import("progress.zig").Progress;

/// This data type contains information about the progress event of an
/// operation.
pub const ProgressEvent = struct {
    /// The Progress event details.
    details: ?Progress = null,
};
