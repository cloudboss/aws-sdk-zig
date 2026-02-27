const NodeToNodeEncryptionOptions = @import("node_to_node_encryption_options.zig").NodeToNodeEncryptionOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// Status of the node-to-node encryption options for the specified
/// Elasticsearch domain.
pub const NodeToNodeEncryptionOptionsStatus = struct {
    /// Specifies the node-to-node encryption options for the specified
    /// Elasticsearch domain.
    options: NodeToNodeEncryptionOptions,

    /// Specifies the status of the node-to-node encryption options for the
    /// specified Elasticsearch domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
