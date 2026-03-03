const ReadReceiptConfig = @import("read_receipt_config.zig").ReadReceiptConfig;

/// Contains network-level configuration settings that apply to all users and
/// security groups within a Wickr network.
pub const NetworkSettings = struct {
    /// Indicates whether the data retention feature is enabled for the network.
    /// When true, messages are captured by the data retention bot for compliance
    /// and archiving purposes.
    data_retention: ?bool = null,

    /// Allows Wickr clients to send anonymized performance and usage metrics to the
    /// Wickr backend server for service improvement and troubleshooting.
    enable_client_metrics: ?bool = null,

    /// Configuration for read receipts at the network level, controlling the
    /// default behavior for whether senders can see when their messages have been
    /// read.
    read_receipt_config: ?ReadReceiptConfig = null,

    pub const json_field_names = .{
        .data_retention = "dataRetention",
        .enable_client_metrics = "enableClientMetrics",
        .read_receipt_config = "readReceiptConfig",
    };
};
