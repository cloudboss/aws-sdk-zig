const EncryptionAtRestOptions = @import("encryption_at_rest_options.zig").EncryptionAtRestOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// Status of the encryption at rest options for the specified OpenSearch
/// Service
/// domain.
pub const EncryptionAtRestOptionsStatus = struct {
    /// Encryption at rest options for the specified domain.
    options: EncryptionAtRestOptions,

    /// The status of the encryption at rest options for the specified domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
