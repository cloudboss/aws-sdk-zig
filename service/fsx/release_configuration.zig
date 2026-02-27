const DurationSinceLastAccess = @import("duration_since_last_access.zig").DurationSinceLastAccess;

/// The configuration that specifies a minimum amount of time since
/// last access for an exported file to be eligible for release from an
/// Amazon FSx for Lustre file system. Only files that were last
/// accessed before this point-in-time can be released. For example, if
/// you specify a last accessed time criteria of 9 days, only files that
/// were last accessed 9.00001 or more days ago can be released.
///
/// Only file data that has been exported to S3 can be released. Files
/// that have not yet been exported to S3, such as new or changed files
/// that have not been exported, are not eligible for release. When files
/// are released, their metadata stays on the file system, so they
/// can still be accessed later. Users and applications can access a
/// released file by reading the file again, which restores data from
/// Amazon S3 to the FSx for Lustre file system.
///
/// If a file meets the last accessed time criteria, its
/// file or directory path must also be specified with the
/// `Paths` parameter of the
/// operation in order
/// for the file to be released.
pub const ReleaseConfiguration = struct {
    /// Defines the point-in-time since an exported file was last accessed,
    /// in order for that file to be eligible for release. Only files that were
    /// last accessed before this point-in-time are eligible to be released from
    /// the file system.
    duration_since_last_access: ?DurationSinceLastAccess,

    pub const json_field_names = .{
        .duration_since_last_access = "DurationSinceLastAccess",
    };
};
