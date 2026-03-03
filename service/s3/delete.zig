const ObjectIdentifier = @import("object_identifier.zig").ObjectIdentifier;

/// Container for the objects to delete.
pub const Delete = struct {
    /// The object to delete.
    ///
    /// **Directory buckets** - For directory buckets, an object
    /// that's composed entirely of whitespace characters is not supported by the
    /// `DeleteObjects`
    /// API operation. The request will receive a `400 Bad Request` error and none
    /// of the objects
    /// in the request will be deleted.
    objects: []const ObjectIdentifier,

    /// Element to enable quiet mode for the request. When you add this element, you
    /// must set its value to
    /// `true`.
    quiet: ?bool = null,
};
