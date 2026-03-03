const CompletedPart = @import("completed_part.zig").CompletedPart;

/// The container for the completed multipart upload details.
pub const CompletedMultipartUpload = struct {
    /// Array of CompletedPart data types.
    ///
    /// If you do not supply a valid `Part` with your request, the service sends
    /// back an HTTP 400
    /// response.
    parts: ?[]const CompletedPart = null,
};
