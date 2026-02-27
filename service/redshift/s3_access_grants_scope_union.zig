const ReadWriteAccess = @import("read_write_access.zig").ReadWriteAccess;

/// A list of scopes set up for S3 Access Grants integration.
pub const S3AccessGrantsScopeUnion = union(enum) {
    /// The S3 Access Grants scope.
    read_write_access: ?ReadWriteAccess,
};
