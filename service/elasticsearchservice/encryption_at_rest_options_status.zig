const EncryptionAtRestOptions = @import("encryption_at_rest_options.zig").EncryptionAtRestOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// Status of the Encryption At Rest options for the specified Elasticsearch
/// domain.
pub const EncryptionAtRestOptionsStatus = struct {
    /// Specifies the Encryption At Rest options for the specified Elasticsearch
    /// domain.
    options: EncryptionAtRestOptions,

    /// Specifies the status of the Encryption At Rest options for the specified
    /// Elasticsearch domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
