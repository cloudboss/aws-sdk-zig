const SSEKMS = @import("ssekms.zig").SSEKMS;
const SSES3 = @import("sses3.zig").SSES3;

/// A container for the encryption of the S3 Storage Lens metrics exports.
pub const StorageLensDataExportEncryption = struct {
    ssekms: ?SSEKMS = null,

    sses3: ?SSES3 = null,
};
