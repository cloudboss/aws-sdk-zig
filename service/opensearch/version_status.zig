const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status of the the OpenSearch or Elasticsearch version options for the
/// specified
/// Amazon OpenSearch Service domain.
pub const VersionStatus = struct {
    /// The OpenSearch or Elasticsearch version for the specified domain.
    options: []const u8,

    /// The status of the version options for the specified domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
