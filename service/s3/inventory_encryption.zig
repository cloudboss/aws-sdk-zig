const SSEKMS = @import("ssekms.zig").SSEKMS;
const SSES3 = @import("sses3.zig").SSES3;

/// Contains the type of server-side encryption used to encrypt the S3 Inventory
/// results.
pub const InventoryEncryption = struct {
    /// Specifies the use of SSE-KMS to encrypt delivered inventory reports.
    ssekms: ?SSEKMS,

    /// Specifies the use of SSE-S3 to encrypt delivered inventory reports.
    sses3: ?SSES3,
};
