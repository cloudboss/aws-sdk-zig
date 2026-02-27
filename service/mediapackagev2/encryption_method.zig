const CmafEncryptionMethod = @import("cmaf_encryption_method.zig").CmafEncryptionMethod;
const IsmEncryptionMethod = @import("ism_encryption_method.zig").IsmEncryptionMethod;
const TsEncryptionMethod = @import("ts_encryption_method.zig").TsEncryptionMethod;

/// The encryption type.
pub const EncryptionMethod = struct {
    /// The encryption method to use.
    cmaf_encryption_method: ?CmafEncryptionMethod,

    /// The encryption method used for Microsoft Smooth Streaming (MSS) content.
    /// This specifies how the MSS segments are encrypted to protect the content
    /// during delivery to client players.
    ism_encryption_method: ?IsmEncryptionMethod,

    /// The encryption method to use.
    ts_encryption_method: ?TsEncryptionMethod,

    pub const json_field_names = .{
        .cmaf_encryption_method = "CmafEncryptionMethod",
        .ism_encryption_method = "IsmEncryptionMethod",
        .ts_encryption_method = "TsEncryptionMethod",
    };
};
