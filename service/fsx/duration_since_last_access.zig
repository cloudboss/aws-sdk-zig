const Unit = @import("unit.zig").Unit;

/// Defines the minimum amount of time since last access for a
/// file to be eligible for release. Only files that have been
/// exported to S3 and that were last accessed or modified before
/// this point-in-time are eligible to be released from the
/// Amazon FSx for Lustre file system.
pub const DurationSinceLastAccess = struct {
    /// The unit of time used by the `Value` parameter to
    /// determine if a file can be released, based on when it was last
    /// accessed. `DAYS` is the only supported value. This
    /// is a required parameter.
    unit: ?Unit = null,

    /// An integer that represents the minimum amount of time (in days)
    /// since a file was last accessed in the file system. Only exported files
    /// with a `MAX(atime, ctime, mtime)` timestamp that is more than
    /// this amount of time in the past (relative to the task create time)
    /// will be released. The default of `Value` is `0`.
    /// This is a required parameter.
    ///
    /// If an exported file meets the last accessed time criteria,
    /// its file or directory path must also be specified in the `Paths`
    /// parameter of the operation
    /// in order for the file to be released.
    value: ?i64 = null,

    pub const json_field_names = .{
        .unit = "Unit",
        .value = "Value",
    };
};
