const DSSEKMSFilter = @import("dssekms_filter.zig").DSSEKMSFilter;
const NotSSEFilter = @import("not_sse_filter.zig").NotSSEFilter;
const SSECFilter = @import("ssec_filter.zig").SSECFilter;
const SSEKMSFilter = @import("ssekms_filter.zig").SSEKMSFilter;
const SSES3Filter = @import("sses3_filter.zig").SSES3Filter;

/// An optional filter for the S3JobManifestGenerator that identifies the subset
/// of objects by encryption type.
pub const ObjectEncryptionFilter = union(enum) {
    /// Filters for objects that are encrypted by dual-layer server-side encryption
    /// with Amazon Web Services Key Management Service (KMS) keys (DSSE-KMS).
    dssekms: ?DSSEKMSFilter,
    /// Filters for objects that are not encrypted by server-side encryption.
    notsse: ?NotSSEFilter,
    /// Filters for objects that are encrypted by server-side encryption with
    /// customer-provided keys (SSE-C).
    ssec: ?SSECFilter,
    /// Filters for objects that are encrypted by server-side encryption with Amazon
    /// Web Services Key Management Service (KMS) keys (SSE-KMS).
    ssekms: ?SSEKMSFilter,
    /// Filters for objects that are encrypted by server-side encryption with Amazon
    /// S3 managed keys (SSE-S3).
    sses3: ?SSES3Filter,
};
