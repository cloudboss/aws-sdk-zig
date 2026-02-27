const OptionStatus = @import("option_status.zig").OptionStatus;

/// Status of the Elasticsearch version options for the specified Elasticsearch
/// domain.
pub const ElasticsearchVersionStatus = struct {
    /// Specifies the Elasticsearch version for the specified Elasticsearch domain.
    options: []const u8,

    /// Specifies the status of the Elasticsearch version options for the specified
    /// Elasticsearch domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
